vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.opt.colorcolumn = "80"

vim.g.nvlime_cl_impl = "ros"

-- Define custom ROSWELL commander
vim.cmd [[
  function! NvlimeBuildServerCommandFor_ros(nvlime_loader, nvlime_eval)
    echo "nvlime_loader: " . a:nvlime_loader
    echo "nvlime_eval: " . a:nvlime_eval
    return ["ros", "run", "-l", a:nvlime_loader, "--eval", a:nvlime_eval]
  endfunction
]]

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    repo,
    "--branch=stable",
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

require("nvim-tree").setup {
  view = {
    side = "right",
    width = 24,
  },
}

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)
