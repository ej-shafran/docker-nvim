local Command = require('docker.command')

---@type docker.cli.container.stats.Opts
local _opts

return Command.new({ 'container', 'stats' })
  :add_option('all', 'boolean')
  :add_option('format', 'string')
  :add_option('no_stream', 'boolean')
  :add_option('no_trunc', 'boolean')
  :build_with_args(_opts)
