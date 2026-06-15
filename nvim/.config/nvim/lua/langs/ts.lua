---@type LangSpec
local html = {
  filetypes = { 'html' },
  mason_tools = { 'html-lsp', 'prettier' },
  treesitter = { 'html' },
  servers = { html = {} },
  formatters_by_ft = { 'prettier' },
}

---@type LangSpec
local css = {
  filetypes = { 'css', 'scss', 'less' },
  mason_tools = { 'css-lsp', 'prettier' },
  treesitter = { 'css' },
  servers = { cssls = {} },
  formatters_by_ft = { 'prettier' },
}

---@type LangSpec
local ts = {
  filetypes = { 'typescript', 'javascript' },
  mason_tools = { 'typescript-language-server' },
  treesitter = { 'typescript', 'javascript' },
  servers = {
    ts_ls = {
      filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
      init_options = {
        plugins = {
          {
            name = '@vue/typescript-plugin',
            location = vim.fn.stdpath('data')
              .. '/mason/packages/vue-language-server/node_modules/@vue/language-server',
            languages = { 'vue' },
          },
        },
      },
    },
  },
  formatters_by_ft = { 'prettier' },
}

---@type LangSpec
local vue = {
  filetypes = { 'vue' },
  mason_tools = { 'vue-language-server' },
  treesitter = { 'vue' },
  servers = { vue_ls = {} },
  formatters_by_ft = { 'prettier' },
}

---@type LangBundle
return {
  langs = { html, css, ts, vue },
}
