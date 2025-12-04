return {
  -- System packages: zathura, zathura-pdf-poppler, chktex, latexmk
  -- Mason: latexindent, texlab
  'lervag/vimtex',
  lazy = false,
  init = function() vim.g.vimtex_view_method = 'zathura' end,
}
