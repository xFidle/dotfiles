-- Lines numbers
vim.o.number = true
vim.o.relativenumber = true

-- Mouse mode
vim.o.mouse = 'a'

-- Basic quality of life options
vim.o.scrolloff = 10
vim.o.confirm = true

-- Visual options
vim.o.showmode = false
vim.o.cursorline = true 
vim.o.signcolumn = 'yes'
vim.o.termguicolors = true

-- Incremental search
vim.o.incsearch = true

-- Undo history file
vim.o.undofile = true 

-- Indenation
vim.o.expandtab = true -- use spaces when <Tab> is inserted 
vim.o.smarttab = true  -- use shiftwidth when inserting <Tab>
vim.o.autoindent = true -- take indent for new line from previous line
vim.o.smartindent = true -- smart autoindenting for C programs
vim.o.breakindent = true -- wrapped line repeats indent
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4

-- Case-insensitive searching (entering single capital char enables case-sensitive searching)
vim.o.ignorecase = true
vim.o.smartcase = true

-- Default splits
vim.o.splitright = true
vim.o.splitbelow = true

-- Whitespace chars
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' } 

