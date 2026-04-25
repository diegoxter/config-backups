return {
  {
    "nvim-focus/focus.nvim",
    version = false,
    opts = {
      autoresize = {
        enable = true,
        width = 0,
        height = 0,
        minwidth = 25,
        minheight = 8,
      },
    },
    excluded_filetypes = { "neo-tree" },
  },
}
