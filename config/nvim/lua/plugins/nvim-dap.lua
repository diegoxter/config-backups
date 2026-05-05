return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "mxsdev/nvim-dap-vscode-js",
    },
    config = function()
      local dap = require("dap")
      local mason_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"

      require("dap-vscode-js").setup({
        debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug",
        adapters = { "pwa-node", "node-terminal", "pwa-chrome", "pwa-msedge" },
      })

      dap.adapters["pwa-node"] = {
        type = "server",
        host = "127.0.0.1",
        port = "${port}",
        executable = {
          command = "node",
          args = { mason_path, "${port}", "127.0.0.1" },
        },
      }

      dap.adapters["node"] = function(cb, config)
        if config.type == "node" then
          config.type = "pwa-node"
        end
        cb(dap.adapters["pwa-node"])
      end

      local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }
      local vscode = require("dap.ext.vscode")
      vscode.type_to_filetypes["node"] = js_filetypes
      vscode.type_to_filetypes["pwa-node"] = js_filetypes
    end,
  },
}
