local Command = require('docker.command')

---@type docker.cli.image.load.Opts
local _opts

return Command.new({ 'image', 'load' })
  :add_option({ name = 'input', type = 'string' })
  :add_option({ name = 'quiet', type = 'boolean' })
  :build(_opts)
