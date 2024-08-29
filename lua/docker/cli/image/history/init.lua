local Command = require('docker.command')

---@type docker.cli.image.history.Opts
local _opts

return Command.new({ 'image', 'history' })
  :add_option('format', 'string')
  :add_option('human', 'boolean')
  :add_option('no_trunc', 'boolean')
  :add_option('quiet', 'boolean')
  :build_with_arg(_opts)
