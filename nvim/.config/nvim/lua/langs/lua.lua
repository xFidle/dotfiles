---@type LangSpec
local lua = {
  filetypes = { 'lua' },
  mason_tools = { 'lua-language-server', 'stylua' },
  treesitter = { 'lua', 'luadoc', 'luap' },
  servers = {
    lua_ls = {
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          telemetry = { enable = false },
        },
      },
    },
  },
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
  langs = { lua },
  plugins = plugins,
}
