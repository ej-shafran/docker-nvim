local Command = require('docker.command')

---@type docker.cli.container.port.Opts
local _opts

return Command.new({ 'container', 'port' }):build_with_args(_opts, { min = 1, max = 2 })
