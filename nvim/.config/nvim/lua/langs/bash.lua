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
  linters_by_ft = { 'shellcheck' },
}

---@type LangBundle
return {
  langs = { bash },
}
