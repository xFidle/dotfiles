return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        hls = { border = 'FloatBorder', preview_border = 'FloatBorder' }
    },
    keys = {
        { '<leader>ff', function() require('fzf-lua').files() end,
            desc = 'Find files' },

        { '<leader>fg', function() require('fzf-lua').live_grep() end,
            desc = 'Find grep' },

        { '<leader>fc', function() require('fzf-lua').files({cwd = vim.fn.expand('$HOME/dotfiles')}) end,
            desc = 'Find config (dotfiles repo) files' },

        { '<leader>fh', function() require('fzf-lua').helptags() end,
            desc = 'Find helptags' },

        { '<leader>fk', function() require('fzf-lua').keymaps() end, 
            desc = 'Find keymaps' },

        { '<leader>fb', function() require('fzf-lua').builtin() end,
            desc = 'Find builtin fuzzy finder' },

        { '<leader>fw', function() require('fzf-lua').grep_cword() end,
            desc = 'Find grep current word' },

        { '<leader>fW', function() require('fzf-lua').grep_cWORD() end,
            desc = 'Find grep current WORD' },

        { '<leader>fo', function() require('fzf-lua').oldfiles() end,
            desc = 'Find old files' },

        { '<leader><leader>', function() require('fzf-lua').buffers() end,
            desc = 'Find active buffers' },

        { '<leader>/', function() require('fzf-lua').lgrep_curbuf() end,
            desc = 'Live grep current buffer' }
    }
}
