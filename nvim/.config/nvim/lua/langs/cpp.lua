---@type LangSpec
local cpp = {
  filetypes = { 'c', 'cpp' },
  mason_tools = { 'clangd', 'clang-format' },
  treesitter = { 'c', 'cpp' },
  servers = {
    clangd = {
      init_options = {
        usePlaceholders = false,
        completeUnimported = true,
        clangdFileStatus = true,
      },
      cmd = {
        'clangd',
        '--background-index',
        '--clang-tidy',
        '--header-insertion=iwyu',
        '--completion-style=detailed',
        '--function-arg-placeholders',
        '--fallback-style=llvm',
      },
      root_markers = {
        'compile_commands.json',
        'compile_flags.txt',
        'configure.ac',
        'Makefile',
        'configure.ac',
        'meson.build',
        'build.ninja',
        '.git',
      },
      capabilities = {
        offsetEncoding = { 'utf-16' },
      },
    },
  },
  keymaps = {
    clangd = {
      { 'n', 'grH', '<CMD>LspClangdSwitchSourceHeader<CR>', { desc = 'Switch Source/Header (C/C++)' } },
    },
  },
  formatters_by_ft = { 'clang-format' },
}

---@type LangSpec
local cmake = {
  filetypes = { 'cmake' },
  mason_tools = { 'neocmakelsp', 'cmakelang', 'cmakelint' },
  treesitter = { 'cmake' },
  servers = { neocmake = {} },
  formatters_by_ft = { 'cmake_format' },
  linters_by_ft = { 'cmakelint' },
}

---TODO: examine cmake-tools.nvim
local plugins = {}

---@type LangBundle
return {
  langs = { cpp, cmake },
  plugins = plugins,
}
