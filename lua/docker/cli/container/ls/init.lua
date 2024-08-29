local Command = require('docker.command')

---@type docker.cli.container.ls.Opts
local _opts

return Command.new({ 'container', 'ls' })
  :add_option('format', 'string')
  :add_option('all', 'boolean')
  :add_option('size', 'boolean')
  :add_option('latest', 'boolean')
  :add_option('last', 'number')
  :add_option('filter', 'record')
  :build(_opts)
