local reg = require('core.registry')

local base = vim.fn.stdpath('config') .. '/lua/langs'
for name in vim.fs.dir(base) do
  local mod = name:match('^(.*)%.lua$')
  if mod then
    local spec = require('langs.' .. mod)
    if type(spec) == 'table' then reg.register(spec) end
  end
end
