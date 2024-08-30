local Command = require('docker.command')

---@type docker.cli.image.rm.Opts
local _opts

return Command.new({ 'image', 'rm' })
  :add_option({ name = 'force', type = 'boolean' })
  :add_option({ name = 'no_prune', type = 'boolean' })
  :build_with_args(_opts)
