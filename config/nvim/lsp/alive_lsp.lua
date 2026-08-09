return {
  cmd = vim.lsp.rpc.connect("127.0.0.1", 8006),
    -- {
    -- "ros",
    -- "run",
    -- "--eval", "(require :asdf)",
    -- "--eval", "(asdf:load-system :alive-lsp)",
    -- "--eval", "(alive/server:start :port 8006)",
  -- },
  filetypes = { "lisp"},
  root_markers = { ".git" }
}
