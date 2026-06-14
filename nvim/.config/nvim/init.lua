vim.loader.enable()

require('config.options')
require('config.keymaps')
require('config.autocmds')
require('config.loader')

require('core.lazy')
require('core.lsp')

local colorscheme = require('utils.colorscheme')
vim.cmd('colorscheme ' .. colorscheme.get_current())
