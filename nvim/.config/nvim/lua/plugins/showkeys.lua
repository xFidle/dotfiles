return { 
    "nvzone/showkeys",
    opts = { maxkeys = 3, winopts = { border = 'rounded' } },
    config = function(_, opts)
        require("showkeys").setup(opts)
        vim.cmd([[ShowkeysToggle]])
    end
}
