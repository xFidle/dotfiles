local reg = require('core.registry')

for name, opts in pairs(reg.get_servers()) do
  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
  callback = function(e)
    local function keymap(mode, keys, func, opts)
      local m = mode or 'n'
      local o = vim.tbl_deep_extend('error', { buffer = e.buf }, opts)
      vim.keymap.set(m, keys, func, o)
    end

    local client = vim.lsp.get_client_by_id(e.data.client_id)
    if not client then return end
    for _, k in ipairs(reg.get_keymaps()[client.name] or {}) do
      keymap(k[1], k[2], k[3], k[4])
    end

    local fzf = require('fzf-lua')

    keymap('n', 'K', vim.lsp.buf.hover, {
      desc = 'Open documentation for symbol under cursor',
    })

    keymap('n', 'grK', vim.lsp.buf.signature_help, {
      desc = 'Open signature help for symbol under cursor',
    })

    keymap('n', 'grd', fzf.lsp_definitions, {
      desc = 'Find definitions',
    })

    keymap('n', 'grD', vim.lsp.buf.declaration, {
      desc = 'Find declarations',
    })

    keymap('n', 'grr', fzf.lsp_references, {
      desc = 'Find references',
    })

    keymap('n', 'gri', fzf.lsp_implementations, {
      desc = 'Goto implementation',
    })

    keymap('n', 'grt', fzf.lsp_typedefs, {
      desc = 'Goto type definition',
    })

    keymap('n', '<leader>cr', vim.lsp.buf.rename, {
      desc = 'Rename all references',
    })

    keymap('n', '<leader>ca', fzf.lsp_code_actions, {
      desc = 'Find possible code actions',
    })
  end,
})

local keymap = vim.keymap.set
keymap('n', '<leader>lr', function()
  vim.cmd.lsp('restart')
end, {
  desc = 'Restart LSP',
})

keymap('n', '<leader>le', function()
  vim.cmd.lsp('enable')
end, {
  desc = 'Enable LSP',
})

keymap('n', '<leader>ld', function()
  vim.cmd.lsp('disable')
end, {
  desc = 'Disable LSP',
})

keymap('n', '<leader>li', function()
  vim.cmd.checkhealth('vim.lsp')
end, {
  desc = 'Display LSP info',
})

keymap('n', ']e', function()
  vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
end, {
  desc = 'Jump to next error',
})

keymap('n', '[e', function()
  vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
end, {
  desc = 'Jump to next error',
})

keymap('n', ']w', function()
  vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.WARN })
end, {
  desc = 'Jump to next error',
})

keymap('n', '[w', function()
  vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.WARN })
end, {
  desc = 'Jump to next error',
})

keymap('n', '<leader>cd', vim.diagnostic.open_float, {
  desc = 'Open float diagnostic window',
})

vim.diagnostic.config({
  severity_sort = true,
  underline = true,
  update_in_insert = true,
  float = { border = 'rounded', source = 'if_many' },
  virtual_text = { current_line = true },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  },
})
