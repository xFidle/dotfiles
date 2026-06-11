return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    branch = 'main',
    main = 'nvim-treesitter',
    init = function()
      local ensure_installed = {
        'bash',
        'c',
        'cpp',
        'css',
        'dockerfile',
        'go',
        'haskell',
        'html',
        'javascript',
        'latex',
        'lua',
        'markdown',
        'markdown_inline',
        'python',
        'regex',
        'query',
        'sql',
        'toml',
        'typescript',
        'vim',
        'vimdoc',
        'vue',
      }
      local already_installed = require('nvim-treesitter.config').get_installed()
      local to_install = vim
        .iter(ensure_installed)
        :filter(function(parser) return not vim.tbl_contains(already_installed, parser) end)
        :totable()
      require('nvim-treesitter').install(to_install)
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    init = function() vim.g.no_plugin_maps = true end,
    opts = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['as'] = '@class.outer',
          ['is'] = '@class.inner',
          ['ac'] = '@comment.outer',
          ['ic'] = '@comment.inner',
        },
      },
    },
  },
}
