local Command = require('docker.command')

---@type docker.cli.image.history.Opts
local _opts

return Command.new({ 'image', 'history' })
  :add_option({ name = 'format', type = 'string' })
  :add_option({ name = 'human', type = 'boolean' })
  :add_option({ name = 'no_trunc', type = 'boolean' })
  :add_option({ name = 'quiet', type = 'boolean' })
  :build_with_arg(_opts)
