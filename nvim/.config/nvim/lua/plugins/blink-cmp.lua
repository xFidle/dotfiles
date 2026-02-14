return {
  {
    'saghen/blink.compat',
    version = '2.*',
    lazy = true,
    opts = {},
  },
  {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets', 'micangl/cmp-vimtex' },
    version = '1.*',
    opts = {
      keymap = {
        preset = 'default',
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
      },
      cmdline = {
        completion = { menu = { auto_show = false } },
      },
      appearance = { nerd_font_variant = 'mono' },
      completion = {
        menu = {
          winhighlight = 'NormalFloat:BlinkCmpMenu',
          scrollbar = true,
          draw = {
            columns = {
              { 'kind_icon', 'label', gap = 1 },
              { 'kind' },
            },
          },
        },
        documentation = {
          auto_show = true,
          treesitter_highlighting = true,
          auto_show_delay_ms = 500,
          window = {
            winhighlight = 'NormalFloat:BlinkCmpDoc',
          },
        },
      },
      signature = {
        enabled = true,
        window = {
          winhighlight = 'NormalFloat:BlinkCmpSignatureHelp',
        },
      },
      sources = {
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer', 'vimtex' },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
          vimtex = {
            name = 'vimtex',
            module = 'blink.compat.source',
            score_offset = 100,
          },
        },
      },
      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
  },
}
