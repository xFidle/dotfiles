local reg = require('core.registry')

return {
  {
    'mason-org/mason.nvim',
    opts = {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    },
    keys = {
      {
        '<leader>M',
        '<CMD>Mason<CR>',
        desc = 'Open Mason window',
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
  },
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
      'mason-org/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    opts = { automatic_enable = false },
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = reg.get_mason_tools(),
      auto_update = true,
      run_on_start = true,
    },
  },
}
