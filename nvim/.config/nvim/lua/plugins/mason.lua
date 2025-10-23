local servers = {
  'basedpyright',
  'clangd',
  'cssls',
  'gopls',
  'html',
  'lua_ls',
  'ts_ls',
  'vue_ls',
  'stylua',
}

local formatters = {
  'stylua',
  'black',
  'clang-format',
}

local linters = {}

local daps = {}

return {
  'mason-org/mason-lspconfig.nvim',
  opts = { ensure_installed = servers },
  dependencies = {
    'neovim/nvim-lspconfig',
    {
      'mason-org/mason.nvim',
      opts = {
        ui = { icons = { package_installed = '✓', package_pending = '➜', package_uninstalled = '✗' } },
      },
    },
    { 'WhoIsSethDaniel/mason-tool-installer.nvim', opts = { ensure_installed = vim.tbl_extend('error', formatters, linters, daps) } },
  },
}
