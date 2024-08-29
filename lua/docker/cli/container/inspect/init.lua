local Command = require('docker.command')

---@type docker.cli.container.inspect.Opts
local _opts

return Command.new({ 'container', 'inspect', '--format', 'json' })
  :add_option('size', 'boolean')
  :build_with_args(_opts, { min = 1 })
