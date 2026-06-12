vim.g.mapleader = ' '
vim.g.maplocalleader = ','

local keymap = vim.keymap.set

-- FLOATING WINDOWS CONFIG
keymap('n', '<leader>L', '<CMD>Lazy<CR>', {
  desc = 'Open Lazy',
})

keymap('n', '<leader>M', '<CMD>Mason<CR>', {
  desc = 'Open Mason',
})

-- GENERAL KEYMAPS
keymap('n', '<Esc>', '<CMD>nohlsearch<CR>', {
  desc = 'Clear search highlight',
})

keymap('n', 'x', '"_x', {
  desc = 'Delete char without yanking',
})

keymap('n', '<leader>;', 'maA;<Esc>`a', {
  desc = 'Put semicolon at end of line',
})

keymap('', '<leader>,', 'maA,<Esc>`a', {
  desc = 'Put coma at end of line',
})

keymap('n', 'J', 'maJ`a', {
  desc = 'Join line below without moving cursor',
})

keymap('v', 'J', [[:m '>+1<CR>gv=gv]], {
  desc = 'Move selection up',
})

keymap('v', 'K', [[:m '<-2<CR>gv=gv]], {
  desc = 'Move selection down',
})

keymap('v', '>', '>gv', {
  desc = 'Indent and keep selection',
})

keymap('v', '<', '<gv', {
  desc = 'Outindent and keep selection',
})

keymap('n', '<leader>sw', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {
  desc = 'Substitute word under cursor',
})

-- FILE OPERATIONS
keymap('n', '<leader>w', '<CMD>w!<CR>', {
  desc = 'Save file',
})

keymap('n', '<leader>q', '<CMD>q!<CR>', {
  desc = 'Quit window',
})

keymap('n', '<leader>r', '<CMD>restart<CR>', {
  desc = 'Restart editor',
})

keymap('n', '<leader>a', 'ggVG', {
  desc = 'Select all',
})

-- WINDOW NAVIGATION
keymap('n', '<leader>sv', '<C-w>v', {
  desc = 'Create vertical split',
})

keymap('n', '<leader>sh', '<C-w>s', {
  desc = 'Create horizontal split',
})

keymap('n', '<C-h>', '<C-w><C-h>', {
  desc = 'Navigate to left window',
})

keymap('n', '<C-j>', '<C-w><C-j>', {
  desc = 'Navigate to below window',
})

keymap('n', '<C-k>', '<C-w><C-k>', {
  desc = 'Navigate to above window',
})

keymap('n', '<C-l>', '<C-w><C-l>', {
  desc = 'Navigate to right window',
})

-- BUFFERS
keymap('n', '<leader>bn', '<CMD>bnext<CR>', {
  desc = 'Move to next buffer',
})

keymap('n', '<leader>bp', '<CMD>bprevious<CR>', {
  desc = 'Move to previous buffer',
})

keymap('n', '<leadr>bd', '<CMD>bdelete<CR>', {
  desc = 'Delete buffer',
})

-- CURSOR BEHAVIOUR
keymap('n', '<C-d>', '<C-d>zz', {
  desc = 'Scroll down and center',
})

keymap('n', '<C-u>', '<C-u>zz', {
  desc = 'Scroll up and center',
})

keymap('n', 'n', 'nzz', {
  desc = 'Jump to next search result and center',
})

keymap('n', 'N', 'Nzz', {
  desc = 'Jump to previous search result and center',
})

-- REGISTERS' OPERATIONS
keymap('n', '<leader>p', [["+p]], {
  desc = 'Paste from system clipboard',
})

keymap('v', '<leader>p', [["_dp]], {
  desc = 'Paste without overwritting register',
})

keymap('n', '<leader>y', [["+y]], {
  desc = 'Yank to clipboard',
})

keymap('v', '<leader>y', [["+y]], {
  desc = 'Yank selection to clipboard',
})

keymap('n', '<leader>d', [["_d]], {
  desc = 'Delete without yanking',
})

keymap('v', '<leader>d', [["_d]], {
  desc = 'Delete selection without yanking',
})

-- Undotree
keymap('n', '<leader>u', function()
  vim.cmd.packadd('nvim.undotree')
  require('undotree').open()
end, {
  desc = 'Toggle undotree',
})
