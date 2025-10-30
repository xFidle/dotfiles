return {
  'nvzone/showkeys',
  opts = {
    maxkeys = 4,
    timeout = 1,
    winopts = { border = 'rounded' },
    winhl = 'FloatBorder:FloatBorder',
  },
  config = function(_, opts)
    require('showkeys').setup(opts)
    vim.cmd([[ShowkeysToggle]])
  end,
}
