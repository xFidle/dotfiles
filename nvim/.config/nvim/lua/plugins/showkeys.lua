return { 
    "nvzone/showkeys",
    cmd = "ShowkeysToggle",
    opts = { maxkeys = 3 },
    lazy = false,
    config = function(_, opts)
        require("showkeys").setup(opts)
        vim.cmd([[ShowkeysToggle]])
    end
}
