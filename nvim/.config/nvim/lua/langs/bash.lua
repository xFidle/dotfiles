---@type LangSpec
local bash = {
  filetypes = { 'bash', 'sh', 'zsh' },
  mason_tools = { 'bash-language-server', 'shfmt', 'shellcheck' },
  treesitter = { 'bash', 'zsh' },
  servers = {
    bashls = {
      filetypes = { 'bash', 'sh', 'zsh' },
      settings = {
        bashIde = {
          shellcheckPath = vim.fn.stdpath('data') .. '/mason/bin/shellcheck',
        },
      },
    },
  },
  formatters_by_ft = { 'shfmt' },
}

---@type LangBundle
return {
  langs = { bash },
}
