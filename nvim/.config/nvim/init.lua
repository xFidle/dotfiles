require('config.options')
require('config.keymaps')
require('config.autocmds')
require('core.lazy')
require('core.lsp')

local path = vim.fn.expand('~/.config/theme/current-theme.conf')
local colorscheme = vim.trim(vim.fn.readfile(path)[1])
vim.cmd('colorscheme ' .. colorscheme)
