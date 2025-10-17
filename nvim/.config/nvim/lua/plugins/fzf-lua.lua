return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        hls = { border = 'FloatBorder', preview_border = 'FloatBorder' }
    },
    keys = {
        { '<leader>ff', function() require('fzf-lua').files() end },
        { '<leader>fg', function() require('fzf-lua').live_grep() end }
    }
}
