local Command = require('docker.command')

---@type docker.cli.container.logs.Opts
local _opts

return Command.new({ 'container', 'logs' })
  :add_option('details', 'boolean')
  :add_option('follow', 'boolean')
  :add_option('since', 'string')
  :add_option('tail', 'string')
  :add_option('timestamps', 'boolean')
  :add_option('until', 'string')
  :build_with_arg(_opts)
