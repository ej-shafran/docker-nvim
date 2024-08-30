local Command = require('docker.command')

---@type docker.cli.container.commit.Opts
local _opts

return Command.new({ 'container', 'commit' })
  :add_option({ name = 'author', type = 'string' })
  :add_option({ name = 'change', type = 'string', list = true })
  :add_option({ name = 'message', type = 'string' })
  :add_option({ name = 'pause', type = 'boolean' })
  :build_with_args(_opts, { min = 1, max = 2 })
