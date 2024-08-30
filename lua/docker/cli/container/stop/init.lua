local Command = require('docker.command')

---@type docker.cli.container.stop.Opts
local _opts

return Command.new({ 'container', 'stop' })
  :add_option({ name = 'signal', type = 'string' })
  :add_option({ name = 'time', type = 'number' })
  :build_with_args(_opts)
