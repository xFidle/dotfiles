---@param scope 'buffer'|'global'
local function toggle_autoformat(scope)
  local is_buffer = scope == 'buffer'
  local var = is_buffer and vim.b or vim.g
  local enable_command = 'FormatEnable'
  local disable_command = is_buffer and 'FormatDisable!' or 'FormatDisable'

  if var.disable_autoformat then
    vim.cmd(enable_command)
    vim.notify('Enabled auto-format witch scope: ' .. scope, vim.log.levels.INFO)
  else
    vim.cmd(disable_command)
    vim.notify('Disabled auto-format with scope: ' .. scope, vim.log.levels.INFO)
  end
end

return {
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  opts = {
    formatters = require('core.registry').get_formatters(),
    formatters_by_ft = require('core.registry').get_formatters_by_ft(),
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
      return { timeout = 500, lsp_format = 'fallback' }
    end,
  },
  keys = {
    {
      '<leader>ct',
      function()
        toggle_autoformat('buffer')
      end,
      desc = 'Toggle auto-format in current buffer',
    },
    {
      '<leader>cT',
      function()
        toggle_autoformat('global')
      end,
      desc = 'Toggle auto-format globally',
    },
    {
      '<leader>cf',
      function()
        require('conform').format({ lsp_format = 'fallback' })
      end,
      desc = 'Format current file',
    },
    {
      '<leader>ci',
      function()
        vim.cmd.checkhealth('conform')
      end,
      desc = 'Display conform info',
    },
  },
  config = function(_, opts)
    require('conform').setup(opts)

    vim.api.nvim_create_user_command('FormatDisable', function(args)
      if args.bang then
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, {
      desc = 'Disable autoformat on save',
      bang = true,
    })

    vim.api.nvim_create_user_command('FormatEnable', function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = 'Enable autoformat on-save',
    })
  end,
}
