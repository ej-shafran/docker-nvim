local Command = require('docker.command')

---@type docker.cli.container.top.Opts
local _opts

return Command.new({ 'container', 'top' }):build_with_args(_opts, { min = 1 })
