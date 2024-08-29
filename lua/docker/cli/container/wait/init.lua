local Command = require('docker.command')

---@type docker.cli.container.wait.Opts
local _opts

return Command.new({ 'container', 'wait' }):build_with_args(_opts, { min = 1 })
