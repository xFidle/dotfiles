return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
        style = "moon",
        transparent = true,
        styles = {
            comments = { italic = true },
            keywords = { italic = false, bold = true },
        },
    },
    config = function(_, opts)
        require("tokyonight").setup(opts)
        vim.cmd([[colorscheme tokyonight]])
    end
}
