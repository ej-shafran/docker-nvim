local Command = require('docker.command')

---@type docker.cli.image.prune.Opts
local _opts

return Command.new({ 'image', 'prune', '--force' })
  :add_option('all', 'boolean')
  :add_option('filter', 'record')
  :build(_opts)
