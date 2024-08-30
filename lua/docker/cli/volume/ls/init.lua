local Command = require('docker.command')

---@type docker.cli.volume.ls.Opts
local _opts

return Command.new({ 'volume', 'ls' })
  :add_option({ name = 'filter', type = 'record' })
  :add_option({ name = 'format', type = 'string' })
  :add_option({ name = 'quiet', type = 'boolean' })
  :build(_opts)
