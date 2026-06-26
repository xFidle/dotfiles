local M = {}

---@return string
function M.get_current()
  local path = vim.fs.joinpath(vim.fn.stdpath('config'), 'themes/current')
  local colorscheme = vim.trim(vim.fn.readfile(path)[1])
  return colorscheme
end

return M
