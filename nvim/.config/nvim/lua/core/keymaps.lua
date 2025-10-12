vim.g.mapleader = " "

-- Clear highlighting after pressing <Esc>
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Char removal
vim.keymap.set('n', 'x', '"_x')

-- Multiline movement
vim.keymap.set('v', 'K', [[:m '<-2<CR>gv=gv]])
vim.keymap.set('v', 'J', [[:m '>+1<CR>gv=gv]])

-- File operations
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>q', ':q<CR>')

-- Window managment
vim.keymap.set('n', '<leader>sv', '<C-w>v<CR>')
vim.keymap.set('n', '<leader>sh', '<C-w>s<CR>')
vim.keymap.set('n', '<C-h>', '<C-w><C-h>')
vim.keymap.set('n', '<C-j>', '<C-w><C-j>')
vim.keymap.set('n', '<C-k>', '<C-w><C-k>')
vim.keymap.set('n', '<C-l>', '<C-w><C-l>')

-- Cenetering screen after changing cursor's position
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')

-- Registers operations
vim.keymap.set('v', '<leader>p', [["_dp]])
vim.keymap.set('n', '<leader>y', [["+y]])
vim.keymap.set('v', '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>d', [["_d]])
vim.keymap.set('v', '<leader>d', [["_d]])
