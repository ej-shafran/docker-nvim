local Command = require('docker.command')

---@type docker.cli.image.save.Opts
local _opts

return Command.new({ 'image', 'save' })
  :add_option({ name = 'output', type = 'string' })
  :build_with_args(_opts, { min = 1 })
