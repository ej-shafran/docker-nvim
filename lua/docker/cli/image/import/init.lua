local Command = require('docker.command')

---@type docker.cli.image.import.Opts
local _opts

return Command.new({ 'image', 'import' })
  :add_list_option('change', 'string')
  :add_option('message', 'string')
  :add_option('platform', 'string')
  :build_with_args(_opts, { min = 1, max = 2 })
