local Command = require('docker.command')

---@type docker.cli.image.import.Opts
local _opts

return Command.new({ 'image', 'import' })
  :add_option({ name = 'change', type = 'string', list = true })
  :add_option({ name = 'message', type = 'string' })
  :add_option({ name = 'platform', type = 'string' })
  :build_with_args(_opts, { min = 1, max = 2 })
