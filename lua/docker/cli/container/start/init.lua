local Command = require('docker.command')

---@type docker.cli.container.start.Opts
local _opts

return Command.new({ 'container', 'start' })
  :add_option('attach', 'boolean')
  :add_option('detach_keys', 'string')
  :add_option('interactive', 'boolean')
  :build_with_args(_opts, { min = 1 })
