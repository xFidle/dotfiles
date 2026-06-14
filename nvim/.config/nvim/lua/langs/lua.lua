---@type LangSpec
local lang = {
  filetypes = { 'lua' },
  mason_tools = { 'lua-language-server', 'stylua' },
  treesitter = { 'lua', 'luadoc', 'luap' },
  servers = { lua_ls = {} },
  formatters_by_ft = { 'stylua' },
}

---@type LazySpec[]
local plugins = {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = { library = { 'lazy.nvim', 'conform.nvim' } },
  },
}

---@type LangBundle
return {
  lang = lang,
  plugins = plugins,
}
