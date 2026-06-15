---@type LangSpec
local python = {
  filetypes = { 'python' },
  mason_tools = { 'pyright', 'ruff' },
  treesitter = { 'python' },
  servers = {
    pyright = {
      settings = {
        pyright = {
          disableOrganizeImports = true,
        },
        python = {
          analysis = {
            ignore = { '*' },
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
          },
        },
      },
    },
    ruff = {
      init_options = {
        settings = {
          configurationPreference = 'filesystemFirst',
          logLevel = 'error',
        },
      },
      on_attach = function(client)
        client.server_capabilities.hoverProvider = false
      end,
    },
  },
  formatters_by_ft = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
}

---@type LangBundle
return {
  langs = { python },
}
