local Command = require('docker.command')

---@type docker.cli.volume.prune.Opts
local _opts

return Command.new({ 'volume', 'prune', '--force' })
  :add_option('all', 'boolean')
  :add_option('filter', 'record')
  :build(_opts)
