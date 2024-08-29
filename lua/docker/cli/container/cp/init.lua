local Command = require('docker.command')

---@type docker.cli.container.cp.Opts
local _opts

return Command.new({ 'container', 'cp' })
  :add_option('archive', 'boolean')
  :add_option('follow_link', 'boolean')
  :add_option('quiet', 'boolean')
  :build_with_args(_opts, { min = 2, max = 2 })
