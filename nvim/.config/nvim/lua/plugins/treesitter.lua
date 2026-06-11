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
    opts = {
      sync_install = false,
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<Enter>',
          node_incremental = '<Enter>',
          node_decremental = '<Backspace>',
          scope_incremental = false,
        },
      },
      highlight = {
        enable = true,
        disable = function(_, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },
    },
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
