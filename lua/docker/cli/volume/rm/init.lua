local Command = require('docker.command')

---@type docker.cli.volume.rm.Opts
local _opts

return Command.new({ 'volume', 'rm' })
  :add_option({ name = 'force', type = 'boolean' })
  :build_with_args(_opts, { min = 1 })
