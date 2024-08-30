local Command = require('docker.command')

---@type docker.cli.container.prune.Opts
local _opts

return Command.new({ 'container', 'prune' })
  :add_option({ name = 'prune', type = 'boolean' })
  :add_option({ name = 'filter', type = 'record' })
  :build(_opts)
