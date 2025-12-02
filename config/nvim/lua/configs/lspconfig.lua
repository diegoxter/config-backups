-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lsp = vim.lsp
local configs = require "lspconfig.configs"
local util = require "lspconfig/util"
local servers = {
  "biome",
  -- "roslyn",
  "eslint",
  "html",
  "cssls",
  "gopls",
  "ols",
  "solidity_ls_nomicfoundation",
  "ts_ls",
  "emmet_language_server",
  "v_analyzer",
}

lsp.enable(servers)
-- vim.roslyn_ls.setup({
--   cmd: {
--    "Microsoft.CodeAnalysis.LanguageServer", "--logLevel", "Information", "--extensionLogDirectory", "/tmp/roslyn_ls/logs", "--stdio"
--   }
-- })
lsp.config("gopls", {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotempl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
})

lsp.config("svelte", {
  cmd = { "svelteserver", "--stdio" },
  filetypes = { "svelte" },
  root_dir = util.root_pattern("package.json", ".git"),
  single_file_support = false,
})

-- vim.lsp.config("eslint", {
--   on_attach = function(client, bufnr)
--     vim.api.nvim_create_autocmd("BufWritePre", {
--       buffer = bufnr,
--       command = "EslintFixAll",
--     })
--   end,
--   filetypes = {
--     "javascript",
--     "javascriptreact",
--     "javascript.jsx",
--     "typescript",
--     "typescriptreact",
--     "typescript.tsx",
--     "vue",
--     "svelte",
--     "astro",
--   },
--   single_file_support = false,
-- })
--
-- lspconfig.ts_ls.setup {
--   on_attach = function(client)
--     client.server_capabilities.documentFormattingProvider = false
--     client.server_capabilities.documentRangeFormattingProvider = false
--   end,
--   filetypes = { "svelte", "typescript", "javascript", "css", "html" },
--   single_file_support = true,
-- }

if not configs.tact_extracted_ls then
  configs.tact_extracted_ls = {
    default_config = {
      cmd = {
        "/home/adriego/.nvm/versions/node/v22.8.0/bin/tact-extracted-ls",
        "--stdio",
      },
      filetypes = { "tact" },
      root_dir = util.root_pattern(".git", "package.json"),
    },
  }
end

lsp.config("tact_extracted_ls", {})
lsp.config("solidity_ls_nomicfoundation", {})
