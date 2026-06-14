---@type LangSpec
local lang = {
  filetypes = { 'bash', 'sh', 'zsh' },
  mason_tools = { 'lua-language-server', 'shfmt', 'shellcheck' },
  treesitter = { 'bash', 'zsh' },
  servers = {
    bashls = {
      filetypes = { 'bash', 'sh', 'zsh' },
    },
  },
  formatters_by_ft = { 'shfmt' },
}

---@type LangBundle
return {
  lang = lang,
}
