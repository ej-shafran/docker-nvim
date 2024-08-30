local Command = require('docker.command')

---@type docker.cli.container.logs.Opts
local _opts

return Command.new({ 'container', 'logs' })
  :add_option({ name = 'details', type = 'boolean' })
  :add_option({ name = 'follow', type = 'boolean' })
  :add_option({ name = 'since', type = 'string' })
  :add_option({ name = 'tail', type = 'string' })
  :add_option({ name = 'timestamps', type = 'boolean' })
  :add_option({ name = 'until', type = 'string' })
  :build_with_arg(_opts)
