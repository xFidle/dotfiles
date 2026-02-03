return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    branch = 'master',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'cpp',
        'css',
        'dockerfile',
        'go',
        'html',
        'javascript',
        'lua',
        'markdown',
        'markdown_inline',
        'python',
        'regex',
        'query',
        'typescript',
        'vim',
        'vimdoc',
        'vue',
      },
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
    branch = 'master',
    main = 'nvim-treesitter.configs',
    opts = {
      textobjects = {
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
  },
}
