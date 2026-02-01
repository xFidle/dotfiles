return {
  {
    lazy = true,
    'folke/tokyonight.nvim',
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
  },
  {
    'vague-theme/vague.nvim',
    lazy = true,
    opts = {
      transparent = true,
      italic = false,
      on_highlights = function(hl, c) hl.NotifyBackground = { bg = c.bg } end,
    },
  },
}
