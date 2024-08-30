local Command = require('docker.command')

---@type docker.cli.container.kill.Opts
local _opts

return Command.new({ 'container', 'kill' })
  :add_option({ name = 'signal', type = 'string' })
  :build_with_args(_opts, { min = 1 })
