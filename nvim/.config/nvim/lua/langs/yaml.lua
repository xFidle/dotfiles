---@type LangSpec
local yaml = {
  filetypes = { 'yml', 'yaml' },
  mason_tools = { 'yaml-language-server' },
  treesitter = { 'yaml' },
  servers = {
    yamlls = {
      capabilities = {
        textDocument = {
          foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          },
        },
      },
      settings = {
        redhat = { telemetry = { enabled = false } },
        yaml = {
          keyOrdering = false,
          format = { enable = true },
          validate = true,
          schemaStore = { enable = false, url = '' },
        },
      },
    },
  },
}

---@type LangBundle
return {
  langs = { yaml },
}
