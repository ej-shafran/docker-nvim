local Command = require('docker.command')

---@type docker.cli.container.attach.Opts
local _opts

return Command.new({ 'container', 'attach' })
  :add_option({ name = 'detach_keys', type = 'string' })
  :add_option({ name = 'no_stdin', type = 'boolean' })
  :add_option({ name = 'sig_proxy', type = 'boolean' })
  :build_with_arg(_opts)
