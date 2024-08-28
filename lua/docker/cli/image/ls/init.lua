local Command = require('docker.command')

---@type docker.cli.image.ls.Opts
local _opts

return Command.new({ 'image', 'ls', '--format', 'json' })
  :add_option('all', 'boolean')
  :add_option('digests', 'boolean')
  :add_option('filter', 'record')
  :build(_opts)
