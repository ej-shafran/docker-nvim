local Command = require('docker.command')

---@type docker.cli.image.inspect.Opts
local _opts

return Command.new({ 'image', 'inspect' }):add_option('format', 'string'):build_with_args(_opts, { min = 1 })
