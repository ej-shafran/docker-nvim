local Command = require('docker.command')

---@type docker.cli.container.rename.Opts
local _opts

return Command.new({ 'container', 'rename' }):build_with_args(_opts, { min = 2, max = 2 })
