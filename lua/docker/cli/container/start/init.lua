local Command = require('docker.command')

---@type docker.cli.container.start.Opts
local _opts

return Command.new({ 'container', 'start' })
  :add_option({ name = 'attach', type = 'boolean' })
  :add_option({ name = 'detach_keys', type = 'string' })
  :add_option({ name = 'interactive', type = 'boolean' })
  :build_with_args(_opts, { min = 1 })
