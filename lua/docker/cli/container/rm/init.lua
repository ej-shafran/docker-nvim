local Command = require('docker.command')

---@type docker.cli.container.rm.Opts
local _opts

return Command.new({ 'container', 'rm' })
  :add_option({ name = 'force', type = 'boolean' })
  :add_option({ name = 'link', type = 'boolean' })
  :add_option({ name = 'volumes', type = 'boolean' })
  :build_with_args(_opts, { min = 1 })
