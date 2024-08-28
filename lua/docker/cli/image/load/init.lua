local Command = require('docker.command')

---@type docker.cli.image.load.Opts
local _opts

return Command.new({ 'image', 'load' }):add_option('input', 'string'):add_option('quiet', 'boolean'):build(_opts)
