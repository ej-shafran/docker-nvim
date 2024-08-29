local Command = require('docker.command')

---@type docker.cli.volume.create.Opts
local _opts

return Command.new({ 'volume', 'create' })
  :add_option('driver', 'string')
  :add_list_option('label', 'string')
  :add_list_option('opt', 'string')
  :build_with_args(_opts, { max = 1 })
