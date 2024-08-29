local Command = require('docker.command')

---@type docker.cli.container.commit.Opts
local _opts

return Command.new({ 'container', 'commit' })
  :add_option('author', 'string')
  :add_list_option('change', 'string')
  :add_option('message', 'string')
  :add_option('pause', 'boolean')
  :build_with_args(_opts, { min = 1, max = 2 })
