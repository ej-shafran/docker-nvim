local Command = require('docker.command')

---@type docker.cli.container.diff.Opts
local _opts

return Command.new({ 'container', 'diff' }):build_with_arg(_opts)
