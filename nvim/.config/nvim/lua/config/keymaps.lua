vim.g.mapleader = ' '

local keymap = vim.keymap.set

-- CONFIG WINDOWS
keymap('n', '<leader>L', '<Cmd>Lazy<CR>', {
    desc = 'Open Lazy' })

keymap('n', '<leader>M', '<Cmd>Mason<CR>', {
    desc = 'Open Mason' })

keymap('n', '<leader>cl', '<Cmd>LspInfo<CR>', {
    desc = 'Open LspInfo'
})

-- GENERAL KEYMAPS
keymap('n', '<Esc>', '<Cmd>nohlsearch<CR>', {
    desc = 'Clear search highlight' })

keymap('n', 'x', '"_x', {
    desc = 'Delete char without yanking' })

keymap('n', '<leader>;', 'maA;<Esc>`a', {
    desc = 'Put semicolon at end of line' })

keymap('n', 'J', 'maJ`a', {
    desc = 'Join line below without moving cursor' })

keymap('v', 'J', [[:m '>+1<CR>gv=gv]], {
    desc = 'Move selection up' })

keymap('v', 'K', [[:m '<-2<CR>gv=gv]], {
    desc = 'Move selection down' })

keymap('v', '>', '>gv', {
    desc = 'Indent and keep selection' })

keymap('v', '<', '<gv', {
    desc = 'Outindent and keep selection' })

keymap('n', '<leader>sw', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {
    desc = 'Substitute word under cursor'})

-- FILE OPERATIONS
keymap('n', '<leader>w', '<Cmd>w<CR>', {
    desc = 'Save file' })

keymap('n', '<leader>q', '<Cmd>q<CR>', {
    desc = 'Quit window' })

-- WINDOW NAVIGATION
keymap('n', '<leader>sv', '<C-w>v', {
    desc = 'Create vertical split' })

keymap('n', '<leader>sh', '<C-w>s', {
    desc = 'Create horizontal split' })

keymap('n', '<C-h>', '<C-w><C-h>', {
    desc = 'Navigate to left window' })

keymap('n', '<C-j>', '<C-w><C-j>', {
    desc = 'Navigate to below window' })

keymap('n', '<C-k>', '<C-w><C-k>', {
    desc = 'Navigate to above window' })

keymap('n', '<C-l>', '<C-w><C-l>', {
    desc = 'Navigate to right window' })

-- BUFFERS
keymap('n', '<leader>bn', ':bnext', {
    desc = 'Move to next buffer'
})

keymap('n', '<leader>bp', ':bprevious', {
    desc = 'Move to previous buffer'
})

keymap('n', '<leadr>bd', '<Cmd>bdelete<CR>', {
    desc = 'Delete buffer' })

-- CURSOR BEHAVIOUR
keymap('n', '<C-d>', '<C-d>zz', {
    desc = 'Scroll down and center' })

keymap('n', '<C-u>', '<C-u>zz', {
    desc = 'Scroll up and center' })

keymap('n', 'n', 'nzz', {
    desc = 'Jump to next search result and center' })

keymap('n', 'N', 'Nzz', {
    desc = 'Jump to previous search result and center' })

-- REGISTERS' OPERATIONS
keymap('n', '<leader>p', [["+p]], {
    desc = 'Paste from system clipboard'})

keymap('v', '<leader>p', [["_dp]], {
    desc = 'Paste without overwritting register' })

keymap('n', '<leader>y', [["+y]], {
    desc = 'Yank to clipboard' })

keymap('v', '<leader>y', [["+y]], {
    desc = 'Yank selection to clipboard' })

keymap('n', '<leader>d', [["_d]], {
    desc = 'Delete without yanking' })

keymap('v', '<leader>d', [["_d]], {
    desc = 'Delete selection without yanking' })

-- DIAGNOSTICS
keymap('n', ']e', function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR }) end, {
    desc = 'Jump to next error'})

keymap('n', '[e', function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR }) end, {
    desc = 'Jump to next error'})

keymap('n', ']w', function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.WARN }) end, {
    desc = 'Jump to next error'})

keymap('n', '[w', function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.WARN }) end, {
    desc = 'Jump to next error'})

keymap('n', '<leader>cd', vim.diagnostic.open_float, {
    desc = 'Open float diagnostic window'
})
