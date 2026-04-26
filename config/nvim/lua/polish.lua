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
