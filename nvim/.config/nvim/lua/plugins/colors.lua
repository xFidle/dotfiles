return {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    style = 'night',
    transparent = true,
    styles = {
      comments = { italic = true },
      keywords = { italic = false, bold = false },
      sidebars = 'normal',
      floats = 'normal',
    },
    on_colors = function(c)
      c.git.add = c.green
      c.git.change = c.yellow
      c.git.remove = c.red
      c.border = c.cyan
    end,
    on_highlights = function(hl, c)
      hl.FloatBorder = { fg = c.blue }
      hl.WinSeparator = { fg = c.blue }
    end,
  },
  config = function(_, opts)
    require('tokyonight').setup(opts)
    vim.cmd([[colorscheme tokyonight]])
  end,
}
