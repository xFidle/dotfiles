---@type LangSpec
local latex = {
  filetypes = { 'tex' },
  mason_tools = { 'texlab', 'latexindent' },
  treesitter = { 'latex', 'bibtex' },
  servers = {
    texlab = {
      settings = {
        texlab = {
          chktex = { onEdit = true, onOpenAndSave = true },
          diagnosticsDelay = 300,
        },
      },
    },
  },
  keymaps = {
    texlab = {
      { 'n', '<leader>K', '<plug>(vimtex-doc-package)', { desc = 'Display vimtex docs', silent = true } },
    },
  },
  formatters = {
    latexindent = {
      prepend_args = { '-m', '-y=modifyLineBreaks:textWrapOptions:columns:120' },
    },
  },
  formatters_by_ft = { 'latexindent' },
}

---@type LazySpec[]
local plugins = {
  'lervag/vimtex',
  lazy = false,
  init = function()
    vim.g.vimtex_view_method = 'zathura'
  end,
}

---@type LangBundle
return {
  langs = { latex },
  plugins = plugins,
}
