local M = {}

---@class Keymap
---@field [1] string
---@field [2] string
---@field [3] string
---@field [4] table?

---@class LangSpec
---@field filetypes string[]
---@field mason_tools? string[]
---@field treesitter? string[]
---@field servers? table<string, vim.lsp.Config>
---@field keymaps? table<string, Keymap[]>
---@field formatters? table<string, conform.FormatterConfigOverride>
---@field formatters_by_ft? string[]

---@class LangBundle
---@field lang LangSpec
---@field plugins? LazySpec[]

---@class Registry
---@field mason_tools? string[]
---@field parsers? string[]
---@field servers? table<string, vim.lsp.Config>
---@field keymaps? table<string, Keymap[]>
---@field formatters? table<string, conform.FormatterConfig>
---@field formatters_by_ft? table<string, string[]>
---@field plugins? LazySpec[]

---@type Registry
local registry = {
  mason_tools = {},
  parsers = {},
  servers = {},
  keymaps = {},
  formatters = {},
  formatters_by_ft = {},
  plugins = {},
}

---@param dst string[]
---@param src? string[]
local function extend_dedup(dst, src)
  for _, v in ipairs(src or {}) do
    if not vim.tbl_contains(dst, v) then
      dst[#dst + 1] = v
    end
  end
end

---@param bundle LangBundle
function M.register(bundle)
  extend_dedup(registry.mason_tools, bundle.lang.mason_tools)
  extend_dedup(registry.parsers, bundle.lang.treesitter)

  for _, v in ipairs(bundle.plugins or {}) do
    registry.plugins[#registry.plugins + 1] = v
  end

  for server, config in pairs(bundle.lang.servers or {}) do
    if not registry.servers[server] then
      registry.servers[server] = config
    end
  end

  for server, keys in pairs(bundle.lang.keymaps or {}) do
    registry.keymaps[server] = registry.keymaps[server] or {}
    extend_dedup(registry.keymaps[server], keys)
  end

  for formatter, config in pairs(bundle.lang.formatters or {}) do
    if not registry.formatters[formatter] then
      registry.formatters[formatter] = config
    end
  end

  local fts = bundle.lang.filetypes
  for _, formatter in ipairs(bundle.lang.formatters_by_ft or {}) do
    for _, filetype in ipairs(fts) do
      registry.formatters_by_ft[filetype] = registry.formatters_by_ft[filetype] or {}
      extend_dedup(registry.formatters_by_ft[filetype], { formatter })
    end
  end
end

---@return Registry
function M.get_registry()
  return registry
end

---@return string[]
function M.get_mason_tools()
  return registry.mason_tools
end

---@return string[]
function M.get_parsers()
  return registry.parsers
end

---@return LazySpec[]
function M.get_plugins()
  return registry.plugins
end

---@return table<string, vim.lsp.Config>
function M.get_servers()
  return registry.servers
end

function M.get_keymaps()
  return registry.keymaps
end

---@return  table<string, conform.FormatterConfig>
function M.get_formatters()
  return registry.formatters
end

---@return table<string, string[]>
function M.get_formatters_by_ft()
  return registry.formatters_by_ft
end

return M
