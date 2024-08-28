local Command = require('docker.command')

---@type docker.cli.image.rm.Opts
local _opts

return Command.new({ 'image', 'rm' })
  :add_option('force', 'boolean')
  :add_option('no_prune', 'boolean')
  :build_with_args(_opts)
