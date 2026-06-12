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
    keys = {
      {
        'af',
        function() require('nvim-treesitter-textobjects.select').select_textobject('@function.outer', 'textobjects') end,
        mode = { 'x', 'o' },
        desc = 'Select around function',
      },
      {
        'if',
        function() require('nvim-treesitter-textobjects.select').select_textobject('@function.inner', 'textobjects') end,
        mode = { 'x', 'o' },
        desc = 'Select inner function',
      },
      {
        'as',
        function() require('nvim-treesitter-textobjects.select').select_textobject('@class.outer', 'textobjects') end,
        mode = { 'x', 'o' },
        desc = 'Select around class',
      },
      {
        'is',
        function() require('nvim-treesitter-textobjects.select').select_textobject('@class.inner', 'textobjects') end,
        mode = { 'x', 'o' },
        desc = 'Select inner class',
      },
      {
        'ac',
        function() require('nvim-treesitter-textobjects.select').select_textobject('@comment.outer', 'textobjects') end,
        mode = { 'x', 'o' },
        desc = 'Select around comment',
      },
      {
        'ic',
        function() require('nvim-treesitter-textobjects.select').select_textobject('@comment.inner', 'textobjects') end,
        mode = { 'x', 'o' },
        desc = 'Select inner comment',
      },
    },
  },
}
