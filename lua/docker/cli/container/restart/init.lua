local Command = require('docker.command')

---@type docker.cli.container.restart.Opts
local _opts

return Command.new({ 'container', 'restart' })
  :add_option('signal', 'string')
  :add_option('time', 'number')
  :build_with_args(_opts, { min = 1 })
