local Command = require('docker.command')

---@type docker.cli.container.exec.Opts
local _opts

return Command.new({ 'container', 'exec' })
  :add_option('detach', 'boolean')
  :add_option('detach_keys', 'string')
  :add_option('env', 'record')
  :add_list_option('env_file', 'string')
  :add_option('interactive', 'boolean')
  :add_option('privileged', 'boolean')
  :add_option('tty', 'boolean')
  :add_option('user', 'string')
  :add_option('workdir', 'string')
  :build_with_args(_opts, { min = 2 })
