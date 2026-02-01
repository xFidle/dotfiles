require('config.options')
require('config.keymaps')
require('config.autocmds')
require('core.lazy')
require('core.lsp')

vim.cmd('colorscheme ' .. require('config.util').get_colorscheme())
