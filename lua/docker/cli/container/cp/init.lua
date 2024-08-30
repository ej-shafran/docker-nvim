local Command = require('docker.command')

---@type docker.cli.container.cp.Opts
local _opts

return Command.new({ 'container', 'cp' })
  :add_option({ name = 'archive', type = 'boolean' })
  :add_option({ name = 'follow_link', type = 'boolean' })
  :add_option({ name = 'quiet', type = 'boolean' })
  :build_with_args(_opts, { min = 2, max = 2 })
