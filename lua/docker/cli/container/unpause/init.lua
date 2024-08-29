local Command = require('docker.command')

---@type docker.cli.container.unpause.Opts
local _opts

return Command.new({ 'container', 'unpause' }):build_with_args(_opts, { min = 1 })
