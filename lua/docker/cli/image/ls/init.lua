local Command = require('docker.command')

---@type docker.cli.image.ls.Opts
local _opts

return Command.new({ 'image', 'ls' })
  :add_option({ name = 'format', type = 'string' })
  :add_option({ name = 'all', type = 'boolean' })
  :add_option({ name = 'digests', type = 'boolean' })
  :add_option({ name = 'filter', type = 'record' })
  :build(_opts)
