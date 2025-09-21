local options = {
  formatters_by_ft = {
    css = { "prettier" },
    go = { "gofumpt", "goimports-reviser", "golines" },
    html = { "prettier" },
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    lua = { "stylua" },
    -- svelte = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 3500,
    lsp_fallback = true,
    async = false,
  },
}

return options
