local M = {}

---@return string
function M.get_current()
  local path = vim.fn.expand('~/.config/theme/current-theme.conf')
  local colorscheme = vim.trim(vim.fn.readfile(path)[1])
  return colorscheme
end

return M
