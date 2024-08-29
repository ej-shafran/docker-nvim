local Command = require('docker.command')

---@type docker.cli.container.rm.Opts
local _opts

return Command.new({ 'container', 'rm' })
  :add_option('force', 'boolean')
  :add_option('link', 'boolean')
  :add_option('volumes', 'boolean')
  :build_with_args(_opts, { min = 1 })
