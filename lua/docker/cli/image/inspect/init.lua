local Command = require('docker.command')

---@param cmd string[]
---@param _ docker.cli.image.inspect.Opts
local function inspect_handler(cmd, _)
  local result = vim.system(cmd, { text = true }):wait()
  assert(result.code == 0, result.stderr)
  local stdout = assert(result.stdout)
  ---@type table
  return vim.json.decode(stdout)
end

return Command.new({ 'image', 'inspect', '--format', 'json' }):build_with_args(inspect_handler, { min = 1 })
