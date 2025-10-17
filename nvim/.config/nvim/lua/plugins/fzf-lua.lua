return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        hls = { border = 'FloatBorder', preview_border = 'FloatBorder' }
    },
    keys = {
        { '<leader>ff', function() require('fzf-lua').files() end },
        { '<leader>fg', function() require('fzf-lua').live_grep() end },
        { '<leader>fc', function() require('fzf-lua').files({cwd = vim.fn.expand('$HOME/dotfiles')}) end },
        { '<leader>fh', function() require('fzf-lua').helptags() end },
        { '<leader>fk', function() require('fzf-lua').keymaps() end },
        { '<leader>fb', function() require('fzf-lua').builtin() end },
        { '<leader>fw', function() require('fzf-lua').grep_cword() end },
        { '<leader>fW', function() require('fzf-lua').grep_cWORD() end },
        { '<leader>fo', function() require('fzf-lua').oldfiles() end },
        { '<leader><leader>', function() require('fzf-lua').buffers() end },
        { '<leader>/', function() require('fzf-lua').lgrep_curbuf() end }
    }
}
