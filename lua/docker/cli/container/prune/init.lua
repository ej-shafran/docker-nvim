local Command = require('docker.command')

---@type docker.cli.container.prune.Opts
local _opts

return Command.new({ 'container', 'prune' }):add_option('prune', 'boolean'):add_option('filter', 'record'):build(_opts)
