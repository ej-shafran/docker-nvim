local Command = require('docker.command')

---@type docker.cli.image.inspect.Opts
local _opts

return Command.new({ 'image', 'inspect', '--format', 'json' }):build_with_args(_opts, { min = 1 })
