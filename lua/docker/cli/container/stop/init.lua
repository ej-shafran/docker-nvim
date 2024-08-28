local Command = require('docker.command')

---@param cmd string[]
---@param _ docker.cli.container.stop.Opts
local function stop_handler(cmd, _)
  local result = vim.system(cmd, { text = true }):wait()
  assert(result.code == 0, result.stderr)
end

return Command.new({ 'container', 'stop' })
  :add_option('signal', 'string')
  :add_option('time', 'number')
  :build_with_args(stop_handler)
