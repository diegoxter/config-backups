require "nvchad.options"

-- add yours here!
vim.g.loaded_python3_provider = 1
vim.g.python3_host_prog = "/usr/bin/python3"

local enable_providers = {
  "python3_provider",
  -- "node_provider",
}

for _, plugin in pairs(enable_providers) do
  vim.g["loaded_" .. plugin] = nil
  vim.cmd("runtime " .. plugin)
end

local o = vim.o

o.list = true
--o.listchars = { space = '·', tab = '»·' }
-- o.cursorlineopt ='both' -- to enable cursorline!
