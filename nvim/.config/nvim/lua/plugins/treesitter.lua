local function setup_autocommand()
  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('TSGroup', { clear = true }),
    pattern = '*',
    callback = function()
      pcall(vim.treesitter.start)
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })
end

local function install_parsers()
  local ensure_installed = {
    'regex',
    'diff',
    'dockerfile',
    'json',
    'markdown',
    'toml',
    'vim',
    'vimdoc',
    'xml',
    'yaml',
  }
  vim.list_extend(ensure_installed, require('core.registry').get_parsers())
  local already_installed = require('nvim-treesitter.config').get_installed()
  local to_install = vim
    .iter(ensure_installed)
    :filter(function(parser)
      return not vim.tbl_contains(already_installed, parser)
    end)
    :totable()
  require('nvim-treesitter').install(to_install)
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    branch = 'main',
    main = 'nvim-treesitter',
    init = function()
      setup_autocommand()
      install_parsers()
    end,
    keys = {
      {
        '<leader>ti',
        function()
          vim.cmd.checkhealth('vim.treesitter')
        end,
        desc = 'Display treesitter info',
      },
      {
        '<Enter>',
        'v_an',
        remap = true,
        desc = 'Initialize incremental selection',
      },
      {
        '<Enter>',
        'an',
        remap = true,
        mode = 'x',
        desc = 'Select parent (outer) node',
      },
      {
        '<Backspace>',
        'in',
        remap = true,
        mode = 'x',
        desc = 'Select child (inner) node',
      },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    init = function()
      vim.g.no_plugin_maps = true
    end,
    keys = {
      {
        'af',
        function()
          require('nvim-treesitter-textobjects.select').select_textobject('@function.outer', 'textobjects')
        end,
        mode = { 'x', 'o' },
        desc = 'Select around function',
      },
      {
        'if',
        function()
          require('nvim-treesitter-textobjects.select').select_textobject('@function.inner', 'textobjects')
        end,
        mode = { 'x', 'o' },
        desc = 'Select inner function',
      },
      {
        'as',
        function()
          require('nvim-treesitter-textobjects.select').select_textobject('@class.outer', 'textobjects')
        end,
        mode = { 'x', 'o' },
        desc = 'Select around class',
      },
      {
        'is',
        function()
          require('nvim-treesitter-textobjects.select').select_textobject('@class.inner', 'textobjects')
        end,
        mode = { 'x', 'o' },
        desc = 'Select inner class',
      },
      {
        'ac',
        function()
          require('nvim-treesitter-textobjects.select').select_textobject('@comment.outer', 'textobjects')
        end,
        mode = { 'x', 'o' },
        desc = 'Select around comment',
      },
      {
        'ic',
        function()
          require('nvim-treesitter-textobjects.select').select_textobject('@comment.inner', 'textobjects')
        end,
        mode = { 'x', 'o' },
        desc = 'Select inner comment',
      },
    },
  },
}
