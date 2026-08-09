return {
  {
    "conform.nvim",
    opts = {
      formatters_by_ft = {
        lisp = { "rosfmt" },
      },
      formatters = {
        rosfmt = {
          command = "ros",
          args = { "fmt", "$FILENAME" },
          stdin = false,
        },
      },
      format_on_save = {
        timeout_ms = 5000,
        lsp_format = "never",
      },
    },
  },
}
