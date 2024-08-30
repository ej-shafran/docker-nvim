local Command = require('docker.command')

---@type docker.cli.container.ls.Opts
local _opts

return Command.new({ 'container', 'ls' })
  :add_option({ name = 'format', type = 'string' })
  :add_option({ name = 'all', type = 'boolean' })
  :add_option({ name = 'size', type = 'boolean' })
  :add_option({ name = 'latest', type = 'boolean' })
  :add_option({ name = 'last', type = 'number' })
  :add_option({ name = 'filter', type = 'record' })
  :build(_opts)
