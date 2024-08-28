local Command = require('docker.command')

---@param cmd string[]
---@param _ docker.cli.image.load.Opts
local function load_handler(cmd, _)
  local result = vim.system(cmd, { text = true }):wait()
  assert(result.code == 0, result.stderr)
end

return Command.new({ 'image', 'load' }):add_option('input', 'string'):add_option('quiet', 'boolean'):build(load_handler)
