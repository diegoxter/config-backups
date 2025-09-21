-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

local options = {
  base46 = {
    theme = "catppuccin",
    theme_toggle = { "yoru", "catppuccin" },

    -- hl_override = {
    -- 	Comment = { italic = true },
    -- 	["@comment"] = { italic = true },
    -- },
  },

  ui = {
    tabufline = {
      order = { "buffers", "tabs", "treeOffset", "btns" },
    },

    cmp = {
      icons_left = false, -- only for non-atom styles!
      lspkind_text = true,
      style = "default", -- default/flat_light/flat_dark/atom/atom_colored
      format_colors = {
        tailwind = false, -- will work for css lsp too
        icon = "󱓻",
      },
    },
  },

  lsp = { signature = true },

  cheatsheet = {
    theme = "grid", -- simple/grid
    excluded_groups = { "terminal (t)", "autopairs", "Nvim", "Opens" }, -- can add group name or with mode
  },

  mason = {
    command = true,
    pkgs = { -- install Mason packages here
      "gopls",
      "stylua",
      "emmet-language-server",
      "gofumpt",
      "goimports-reviser",
      "golines",
    },
  },
}

local status, chadrc = pcall(require, "chadrc")
return vim.tbl_deep_extend("force", options, status and chadrc or {})
