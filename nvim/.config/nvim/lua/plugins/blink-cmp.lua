local feat_options = {
  keymap = {
    preset = 'default',
    ['<C-k>'] = { 'select_prev', 'fallback' },
    ['<C-j>'] = { 'select_next', 'fallback' },
  },
  appearance = {
    use_nvim_cmp_as_default = false,
    nerd_font_variant = 'mono',
  },
  cmdline = {
    completion = {
      menu = { auto_show = false },
      ghost_text = { show_with_menu = false },
    },
  },
  completion = {
    menu = {
      auto_show = true,
      auto_show_delay_ms = 500,
      draw = {
        treesitter = { 'lsp' },
      },
    },
    list = {
      selection = {
        preselect = true,
        auto_insert = false,
      },
    },
    accept = {
      auto_brackets = { enabled = true },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 500,
      treesitter_highlighting = true,
    },
    ghost_text = { enabled = true, show_without_menu = false },
  },
  sources = {
    default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
    providers = {
      dadbod = {
        name = 'Dadbod',
        module = 'vim_dadbod_completion.blink',
      },
      lazydev = {
        name = 'LazyDev',
        module = 'lazydev.integrations.blink',
        score_offset = 100,
      },
    },
  },
  signature = { enabled = true },
  fuzzy = { implementation = 'rust' },
}

local ui_options = {
  completion = {
    menu = {
      draw = {
        columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', 'kind', 'source_name', gap = 1 } },
      },
    },
  },
}

return {
  {
    'saghen/blink.compat',
    version = '2.*',
    lazy = true,
    opts = {},
  },
  {
    'saghen/blink.cmp',
    dependencies = {
      'saghen/blink.lib',
      'rafamadriz/friendly-snippets',
    },
    build = function()
      ---@diagnostic disable-next-line
      require('blink.cmp').build():pwait()
    end,
    opts = vim.tbl_deep_extend('error', feat_options, ui_options),
  },
}
