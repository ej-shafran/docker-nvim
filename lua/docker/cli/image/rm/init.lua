local Command = require('docker.command')

---@param cmd string[]
---@param _ docker.cli.image.rm.Opts
local function rm_handler(cmd, _)
  local result = vim.system(cmd, { text = true }):wait()
  assert(result.code == 0, result.stderr)
end

return Command.new({ 'image', 'rm' })
  :add_option('force', 'boolean')
  :add_option('no_prune', 'boolean')
  :build_with_args(rm_handler)
