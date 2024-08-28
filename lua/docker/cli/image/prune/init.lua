local Command = require('docker.command')

---@param cmd string[]
---@param _ docker.cli.image.prune.Opts
local function prune_handler(cmd, _)
  local result = vim.system(cmd, { text = true }):wait()
  assert(result.code == 0, result.stderr)
end

return Command.new({ 'image', 'prune', '--force' })
  :add_option('all', 'boolean')
  :add_option('filter', 'record')
  :build(prune_handler)
