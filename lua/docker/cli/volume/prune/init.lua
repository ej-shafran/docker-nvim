local Command = require('docker.command')

---@type docker.cli.volume.prune.Opts
local _opts

return Command.new({ 'volume', 'prune' })
  :add_option({ name = 'force', type = 'boolean' })
  :add_option({ name = 'all', type = 'boolean' })
  :add_option({ name = 'filter', type = 'record' })
  :build(_opts)
