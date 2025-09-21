return {
  { import = "nvchad.blink.lazyspec" },
  {
    "mason-org/mason.nvim",
    opts = {
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
    },
  },
  {
    "m4xshen/hardtime.nvim",
    lazy = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
  },
  {
    "seblyng/roslyn.nvim",
    ft = "cs",
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
      -- your configuration comes here; leave empty for default settings
    },
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre", "BufNewFile" }, -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
    --   opts = {
    -- 	servers = {
    -- 		tsserver = {
    -- 			on_attach = function(client)
    -- 				client.server_capabilities.documentFormattingProvider = false
    -- 			end,
    -- 		},
    -- },
  },
  -- {
  --   "nvimtools/none-ls.nvim",
  --   opts = function()
  --     return require "configs.none-ls"
  --   end,
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  -- },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function(_, opts)
      require("gopher").setup(opts)
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
    ---@type gopher.Config
    opts = {},
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    ft = { "lisp", "commonlisp" },
  },
  {
    "0x00-ketsu/autosave.nvim",
    lazy = false,
    opts = {
      debounce_delay = 5505,
    },
  },
  -- {
  --   "tact-lang/tact.vim",
  --   init = require("configs.tact").setup,
  --   ft = "tact",
  -- },
  -- {
  --   "Olical/conjure",
  --   ft = { "clojure", "fennel", "python", "lisp" }, -- etc
  --   lazy = true,
  -- },
  -- {
  --   "kovisoft/slimv",
  --   ft = { "lisp", "commonlisp", "clojure", "scheme" },
  --   config = function()
  --     vim.g.slimv_swank_cmd = "! ros run -l ~/.local/share/nvim/lazy/slimv/slime/start-swank.lisp &"
  --     vim.g.slimv_repl_split = 0
  --   end,
  -- },
  {
    "monkoose/nvlime",
    ft = "lisp",

    dependencies = {
      "monkoose/parsley",
    },

    init = function()
      vim.g.nvlime_config = {
        leader = ",",
        autodoc = {
          enabled = false,
          max_level = 5,
          max_lines = 50,
        },
        cmp = { enabled = true },
        implementation = "ros",
      }
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = {
      sources = {
        { name = "nvlime" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" }, -- Add buffer source
        { name = "path" },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "html",
        "css",
        "go",
        -- "tsx",
        -- "svelte",
        "typescript",
        "javascript",
        "commonlisp",
        "solidity",
      },
    },
  },
}
