---@type LangSpec
local lang = {
  filetypes = { 'go' },
  mason_tools = { 'gopls', 'golangci-lint-langserver', 'gofumpt', 'goimports', 'golines', 'impl' },
  treesitter = { 'go', 'gomod', 'gosum' },
  servers = {
    golangci_lint_ls = {},
    gopls = {
      init_options = {
        semanticTokens = true,
      },
      settings = {
        gopls = {
          gofumpt = true,
          completeUnimported = true,
          staticcheck = true,
          analyses = {
            nilness = true,
            useany = true,
            unusedparams = true,
            unusedwrite = true,
            unusedvariable = true,
            shadow = true,
          },
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
          directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules' },
        },
      },
    },
  },
  formatters = {
    golines = {
      prepend_args = { '-m', '120' },
    },
  },
  formatters_by_ft = { 'gofumpt', 'goimports', 'golines' },
}

---@type LangBundle
return {
  lang = lang,
}
