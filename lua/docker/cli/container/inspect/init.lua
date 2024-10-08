local Command = require('docker.command')

---@type docker.cli.container.inspect.Opts
local _opts

return Command.new({ 'container', 'inspect' })
  :add_option({ name = 'format', type = 'string' })
  :add_option({ name = 'size', type = 'boolean' })
  :build_with_args(_opts, { min = 1 })
