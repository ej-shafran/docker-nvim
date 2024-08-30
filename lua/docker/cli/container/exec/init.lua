local Command = require('docker.command')

---@type docker.cli.container.exec.Opts
local _opts

return Command.new({ 'container', 'exec' })
  :add_option({ name = 'detach', type = 'boolean' })
  :add_option({ name = 'detach_keys', type = 'string' })
  :add_option({ name = 'env', type = 'record' })
  :add_option({ name = 'env_file', type = 'string', list = true })
  :add_option({ name = 'interactive', type = 'boolean' })
  :add_option({ name = 'privileged', type = 'boolean' })
  :add_option({ name = 'tty', type = 'boolean' })
  :add_option({ name = 'user', type = 'string' })
  :add_option({ name = 'workdir', type = 'string' })
  :build_with_args(_opts, { min = 2 })
