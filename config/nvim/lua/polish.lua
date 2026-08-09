-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Habilita el ajuste de línea visual
vim.opt.wrap = true
-- Evita que las palabras se corten a la mitad al ajustar
vim.opt.linebreak = true
-- Desactiva el corte de línea "duro" automático
vim.opt.textwidth = 0
-- Asegura que no haya márgenes de ajuste adicionales
vim.opt.wrapmargin = 0
-- Linea vertical en la columna XX
vim.opt.colorcolumn = "80"
vim.api.nvim_set_hl(0, "MatchParen", { bg = "#505050", fg = "white", bold = true })


local ignore_filetypes = { 'neo-tree' }
local ignore_buftypes = { 'nofile', 'prompt', 'popup' }

local augroup =
    vim.api.nvim_create_augroup('FocusDisable', { clear = true })

vim.api.nvim_create_autocmd('WinEnter', {
    group = augroup,
    callback = function(_)
        if vim.tbl_contains(ignore_buftypes, vim.bo.buftype)
        then
            vim.w.focus_disable = true
        else
            vim.w.focus_disable = false
        end
    end,
    desc = 'Disable focus autoresize for BufType',
})

vim.api.nvim_create_autocmd('FileType', {
    group = augroup,
    callback = function(_)
        if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
            vim.b.focus_disable = true
        else
            vim.b.focus_disable = false
        end
    end,
    desc = 'Disable focus autoresize for FileType',
})

local function swank_running(port)
  port = port or 4005
   local cmd = string.format("ss -ltn | grep -qE ':%d([[:space:]]|$)'", port)
  vim.fn.system({ "sh", "-c", cmd })
  return vim.v.shell_error == 0
end

local function ensure_swank()
  if swank_running(4005) then
    return
  end

  vim.fn.jobstart({
    "ros", "run",
    "--eval", "(ql:quickload :swank)",
    "--eval", "(swank:create-server :port 4005 :dont-close t)",
  }, { detach = true })
end

local state = {
  should_connect = false,
  conjure_connected = false,
    alive = {
        job_id = nil,
        port = 8006
    }
}

local alive = state.alive
local function alive_running_p()
  return alive.job_id ~= nil
    and vim.fn.jobwait({ alive.job_id }, 0)[1] == -1
end

local function start_alive()
  if alive_running_p() then
    return
  end

  alive.job_id = vim.fn.jobstart({
    "ros",
    "run",
    "--eval", "(require :asdf)",
    "--eval", "(asdf:load-system :alive-lsp)",
    "--eval", string.format("(alive/server:start :port %d)", alive.port),
  }, {
    detach = false,
  })
end

local function stop_alive()
  if alive_running_p() then
    vim.fn.jobstop(alive.job_id)
  end

  alive.job_id = nil
end

vim.api.nvim_create_autocmd("VimLeavePre", {
 callback = function()
    if alive_running_p() then
      stop_alive()
    end
  end,
})

local function wait_for_alive(callback, attempt)
  attempt = attempt or 0

  if attempt >= 50 then
    vim.notify(
      "Alive no abrió el puerto 8006 en 5 segundos",
      vim.log.levels.ERROR
    )
    return
  end

  local tcp = vim.uv.new_tcp()

  tcp:connect("127.0.0.1", alive.port, function(err)
    tcp:close()

    if not err then
      vim.schedule(callback)
      return
    end

    vim.defer_fn(function()
      wait_for_alive(callback, attempt + 1)
    end, 100)
  end)
end


vim.api.nvim_create_autocmd("FileType", {
  pattern = "lisp",
  callback = function(event)
  if not state.should_connect then
    return
  end

    local bufnr = event.buf

    ensure_swank()
    start_alive()

    if not state.alive_lsp_enabled then
      state.alive_lsp_enabled = true

      wait_for_alive(function()
        vim.lsp.enable("alive_lsp")

        vim.lsp.start(vim.lsp.config.alive_lsp, {
          bufnr = bufnr,
        })
      end)
    end

    if not state.conjure_connected then
      vim.defer_fn(function()
        vim.cmd("ConjureConnect")
        state.conjure_connected = true
      end, 500)
    end
  end,
})

vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
    expr = true,
    replace_keycodes = false
})
vim.g.copilot_no_tab_map = true

