local Command = require('docker.command')

---@type docker.cli.volume.inspect.Opts
local _opts

return Command.new({ 'volume', 'inspect' })
  :add_option({ name = 'format', type = 'string' })
  :build_with_args(_opts, { min = 1 })
