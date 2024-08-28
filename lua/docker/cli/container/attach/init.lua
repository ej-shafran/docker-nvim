local Command = require('docker.command')

---@type docker.cli.container.attach.Opts
local _opts

return Command.new({ 'container', 'attach' })
  :add_option('detach_keys', 'string')
  :add_option('no_stdin', 'boolean')
  :add_option('sig_proxy', 'boolean')
  :build_with_arg(_opts)
