local Command = require('docker.command')

---@type docker.cli.image.prune.Opts
local _opts

return Command.new({ 'image', 'prune' })
  :add_option({ name = 'force', type = 'boolean' })
  :add_option({ name = 'all', type = 'boolean' })
  :add_option({ name = 'filter', type = 'record' })
  :build(_opts)
