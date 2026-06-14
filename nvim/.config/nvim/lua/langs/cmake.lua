---@type LangSpec
local lang = {
  filetypes = { 'cmake' },
  mason_tools = { 'neocmake', 'cmakelang', 'cmakelint' },
  treesitter = { 'cmake' },
  servers = {
    neocmake = {},
  },
  formatters_by_ft = { 'cmake_format' },
  linters_by_ft = { 'cmakelint' },
}

---TODO: examine cmake-tools.nvim
local plugins = {}

---@type LangBundle
return {
  lang = lang,
  plugins = plugins,
}
