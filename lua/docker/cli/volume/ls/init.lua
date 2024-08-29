local Command = require('docker.command')

---@type docker.cli.volume.ls.Opts
local _opts

return Command.new({ 'volume', 'ls' })
  :add_option('filter', 'record')
  :add_option('format', 'string')
  :add_option('quiet', 'boolean')
  :build(_opts)
