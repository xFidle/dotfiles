return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  version = '1.*',
  opts = {
    keymap = {
      preset = 'default',
      ['<C-k>'] = { 'select_prev', 'fallback' },
      ['<C-j>'] = { 'select_next', 'fallback' },
    },
    appearance = { nerd_font_variant = 'mono' },
    completion = {
      menu = {
        winhighlight = 'BlinkCmpMenu:NormalFloat',
        scrollbar = true,
        draw = {
          columns = {
            { 'kind_icon', 'label', gap = 1 },
            { 'label_description' },
            { 'kind' },
          },
        },
      },
      documentation = { auto_show = true },
    },
    signature = {
      enabled = true,
      window = {
        winhighlight = 'BlinkCmpSignatureHelp:NormalFloat',
      },
    },
    sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
    fuzzy = { implementation = 'prefer_rust_with_warning' },
  },
}
