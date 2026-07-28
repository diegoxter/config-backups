return {
  "saghen/blink.cmp",
  optional = true,
  dependencies = {
    "PaterJason/cmp-conjure",
  },
  specs = {
    {
      "saghen/blink.compat",
      version = "*",
      lazy = true,
      opts = {},
    },
  },
  opts = {
    sources = {
      default = { "conjure" },
      providers = {
        conjure = {
          name = "conjure",
          module = "blink.compat.source",
          score_offset = -1,
        },
      },
    },
  },
}
