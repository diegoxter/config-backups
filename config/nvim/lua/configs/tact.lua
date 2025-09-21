local M = {}

function M.setup()
  vim.g.tact_blank_identifiers = 1 -- variables and constants highlighting
  vim.g.tact_style_guide = 1 -- tact style guide
  vim.g.tact_prefer_completefunc = 1 -- auto complete
end

return M
