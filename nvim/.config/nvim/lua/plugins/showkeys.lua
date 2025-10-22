return {
  'nvzone/showkeys',
  opts = { maxkeys = 5, winopts = { border = 'rounded' } },
  config = function(_, opts)
    require('showkeys').setup(opts)
    vim.cmd([[ShowkeysToggle]])
  end,
}
