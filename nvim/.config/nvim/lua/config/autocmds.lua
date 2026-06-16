vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd('WinEnter', {
  group = vim.api.nvim_create_augroup('cursorline', { clear = true }),
  desc = 'Enable cursorline in floating windows',
  callback = function()
    local win = vim.api.nvim_get_current_win()
    vim.schedule(function()
      if not vim.api.nvim_win_is_valid(win) then return end
      vim.wo[win].cursorline = true
    end)
  end,
})
