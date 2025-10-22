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

local utils = {
  'stylua',
}

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
    { 'WhoIsSethDaniel/mason-tool-installer.nvim', opts = { ensure_installed = utils } },
  },
}
