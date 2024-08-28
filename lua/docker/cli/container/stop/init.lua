local Command = require('docker.command')

---@type docker.cli.container.stop.Opts
local _opts

return Command.new({ 'container', 'stop' })
  :add_option('signal', 'string')
  :add_option('time', 'number')
  :build_with_args(_opts)
