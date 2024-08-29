local Command = require('docker.command')

---@type docker.cli.container.pause.Opts
local _opts

return Command.new({ 'container', 'pause' }):build_with_args(_opts, { min = 1 })
