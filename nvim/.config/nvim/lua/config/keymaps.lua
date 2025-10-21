vim.g.mapleader = ' '

-- GENERAL KEYMAPS
vim.keymap.set('n', '<Esc>', '<Cmd>nohlsearch<CR>', {
    desc = 'Clear search highlight' })

vim.keymap.set('n', '<leader>L', '<Cmd>Lazy<CR>', {
    desc = 'Open Lazy' })

vim.keymap.set('n', 'x', '"_x', {
    desc = 'Delete char without yanking' })

vim.keymap.set('n', '<leader>;', 'maA;<Esc>`a', {
    desc = 'Put semicolon at end of line' })

vim.keymap.set('n', 'J', 'maJ`a', {
    desc = 'Join line below without moving cursor' })

vim.keymap.set('v', 'J', [[:m '>+1<CR>gv=gv]], {
    desc = 'Move selection up' })

vim.keymap.set('v', 'K', [[:m '<-2<CR>gv=gv]], {
    desc = 'Move selection down' })

vim.keymap.set('v', '>', '>gv', {
    desc = 'Indent and keep selection' })

vim.keymap.set('v', '<', '<gv', {
    desc = 'Outindent and keep selection' })

vim.keymap.set('n', '<leader>sw', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {
    desc = 'Substitute word under cursor'})

-- FILE OPERATIONS
vim.keymap.set('n', '<leader>w', '<Cmd>w<CR>', {
    desc = 'Save file' })

vim.keymap.set('n', '<leader>q', '<Cmd>q<CR>', {
    desc = 'Quit window' })

-- WINDOW NAVIGATIONS
vim.keymap.set('n', '<leader>sv', '<C-w>v', {
    desc = 'Create vertical split' })

vim.keymap.set('n', '<leader>sh', '<C-w>s', {
    desc = 'Create horizontal split' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', {
    desc = 'Navigate to left window' })

vim.keymap.set('n', '<C-j>', '<C-w><C-j>', {
    desc = 'Navigate to below window' })

vim.keymap.set('n', '<C-k>', '<C-w><C-k>', {
    desc = 'Navigate to above window' })

vim.keymap.set('n', '<C-l>', '<C-w><C-l>', {
    desc = 'Navigate to right window' })

-- CURSOR BEHAVIOUR
vim.keymap.set('n', '<C-d>', '<C-d>zz', {
    desc = 'Scroll down and center' })

vim.keymap.set('n', '<C-u>', '<C-u>zz', {
    desc = 'Scroll up and center' })

vim.keymap.set('n', 'n', 'nzz', {
    desc = 'Jump to next search result and center' })

vim.keymap.set('n', 'N', 'Nzz', {
    desc = 'Jump to previous search result and center' })


-- REGISTERS' OPERATIONS
vim.keymap.set('n', '<leader>p', [["+p]], {
    desc = 'Paste from system clipboard'})

vim.keymap.set('v', '<leader>p', [["_dp]], {
    desc = 'Paste without overwritting register' })

vim.keymap.set('n', '<leader>y', [["+y]], {
    desc = 'Yank to clipboard' })

vim.keymap.set('v', '<leader>y', [["+y]], {
    desc = 'Yank selection to clipboard' })

vim.keymap.set('n', '<leader>d', [["_d]], {
    desc = 'Delete without yanking' })

vim.keymap.set('v', '<leader>d', [["_d]], {
    desc = 'Delete selection without yanking' })
