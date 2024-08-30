local Command = require('docker.command')

---@type docker.cli.container.stats.Opts
local _opts

return Command.new({ 'container', 'stats' })
  :add_option({ name = 'all', type = 'boolean' })
  :add_option({ name = 'format', type = 'string' })
  :add_option({ name = 'no_stream', type = 'boolean' })
  :add_option({ name = 'no_trunc', type = 'boolean' })
  :build_with_args(_opts)
