local Command = require('docker.command')

---@type docker.cli.container.inspect.Opts
local _opts

return Command.new({ 'container', 'inspect' })
  :add_option('format', 'string')
  :add_option('size', 'boolean')
  :build_with_args(_opts, { min = 1 })
