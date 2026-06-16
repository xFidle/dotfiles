local function get_disabled_keyamps()
  local keymaps = {}
  local disabled = { '<C-h>', '<C-j>', '<C-k>', '<C-l>' }
  for _, lhs in ipairs(disabled) do
    keymaps[lhs] = false
  end
  return keymaps
end

return {
  'stevearc/oil.nvim',
  dependencies = { { 'nvim-mini/mini.icons', opts = {} } },
  opts = {
    default_file_explorer = true,
    delete_to_trash = true,
    watch_for_changes = true,
    view_options = {
      show_hidden = true,
    },
    keymaps = get_disabled_keyamps(),
  },
  keys = {
    {
      '-',
      function()
        require('oil').open()
      end,
      desc = 'Open oil',
    },

    {
      '_',
      function()
        require('oil').open(vim.fn.getcwd())
      end,
      desc = 'Open oil in cwd',
    },
  },
}
