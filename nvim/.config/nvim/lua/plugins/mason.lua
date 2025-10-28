local servers = {
  'basedpyright',
  'clangd',
  'cssls',
  'gopls',
  'html',
  'lua_ls',
  'ts_ls',
  'vue_ls',
}

local tools = {
  'stylua',
  'clang-format',
  'ruff',
}

return {
  'mason-org/mason-lspconfig.nvim',
  opts = { ensure_installed = servers },
  dependencies = {
    'neovim/nvim-lspconfig',
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
    },
    {
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      opts = { ensure_installed = vim.tbl_extend('force', servers, tools) },
    },
  },
}
