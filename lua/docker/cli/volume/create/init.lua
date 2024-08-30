local Command = require('docker.command')

---@type docker.cli.volume.create.Opts
local _opts

return Command.new({ 'volume', 'create' })
  :add_option({ name = 'driver', type = 'string' })
  :add_option({ name = 'label', type = 'string', list = true })
  :add_option({ name = 'opt', type = 'string', list = true })
  :build_with_args(_opts, { max = 1 })
