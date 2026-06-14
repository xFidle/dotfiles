local M = {}

---@class Keymap
---@field [1] string
---@field [2] string
---@field [3] string|function
---@field [4] table?

---@class LangSpec
---@field filetypes string[]
---@field mason_tools? string[]
---@field treesitter? string[]
---@field servers? table<string, vim.lsp.Config>
---@field formatters? table<string, conform.FormatterConfigOverride>
---@field formatters_by_ft? string[]
---@field linters_by_ft? string[]
---@field keymaps? table<string, Keymap[]>

---@class LangBundle
---@field lang LangSpec
---@field plugins? LazySpec[]

---@class Registry
---@field mason_tools? string[]
---@field parsers? string[]
---@field servers? table<string, vim.lsp.Config>
---@field formatters? table<string, conform.FormatterConfig>
---@field formatters_by_ft? table<string, string[]>
---@field linters_by_ft? table<string, string[]>
---@field keymaps? table<string, Keymap[]>
---@field plugins? LazySpec[]

---@type Registry
local registry = {
  mason_tools = {},
  parsers = {},
  servers = {},
  keymaps = {},
  formatters = {},
  formatters_by_ft = {},
  linters_by_ft = {},
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

---@param dst table<string, any>
---@param src? table<string, any>
local function merge_keep(dst, src)
  for k, v in pairs(src or {}) do
    if not dst[k] then
      dst[k] = v
    end
  end
end

---@param dst table<string, any>
---@param src? table<string, any>
local function merge_extend(dst, src)
  for k, v in pairs(src or {}) do
    dst[k] = dst[k] or {}
    extend_dedup(dst[k], v)
  end
end

---@param dst table<string, string[]>
---@param fts string[]
---@param names? string[]
local function register_by_ft(dst, fts, names)
  for _, entry in ipairs(names or {}) do
    for _, filetype in ipairs(fts) do
      dst[filetype] = dst[filetype] or {}
      extend_dedup(dst[filetype], { entry })
    end
  end
end

---@param bundle LangBundle
function M.register(bundle)
  extend_dedup(registry.mason_tools, bundle.lang.mason_tools)
  extend_dedup(registry.parsers, bundle.lang.treesitter)
  merge_keep(registry.servers, bundle.lang.servers)
  merge_keep(registry.formatters, bundle.lang.formatters)
  register_by_ft(registry.formatters_by_ft, bundle.lang.filetypes, bundle.lang.formatters_by_ft)
  register_by_ft(registry.linters_by_ft, bundle.lang.filetypes, bundle.lang.linters_by_ft)
  merge_extend(registry.keymaps, bundle.lang.keymaps)
  vim.list_extend(registry.plugins, bundle.plugins or {})
end

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

---@return table<string, vim.lsp.Config>
function M.get_servers()
  return registry.servers
end

---@return  table<string, conform.FormatterConfig>
function M.get_formatters()
  return registry.formatters
end

---@return table<string, string[]>
function M.get_formatters_by_ft()
  return registry.formatters_by_ft
end

---@return table<string, string[]>
function M.get_linters_by_ft()
  return registry.linters_by_ft
end

---@return table<string, Keymap[]>
function M.get_keymaps()
  return registry.keymaps
end

---@return LazySpec[]
function M.get_plugins()
  return registry.plugins
end

return M
