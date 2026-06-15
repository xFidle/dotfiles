---@type LangSpec
local haskell = {
  filetypes = { 'haskell' },
  mason_tools = { 'haskell-language-server', 'hlint', 'ormolu' },
  treesitter = { 'haskell' },
  servers = {
    hls = {
      settings = {
        haskell = {
          formattingProvider = 'ormolu',
          plugin = { hlint = { globalOn = true } },
        },
      },
    },
  },
  linters_by_ft = { 'hlint' },
}

---@type LangBundle
return {
  langs = { haskell },
}
