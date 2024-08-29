local Command = require('docker.command')

---@type docker.cli.container.export.Opts
local _opts

return Command.new({ 'container', 'export' }):add_option('output', 'string'):build_with_arg(_opts)
