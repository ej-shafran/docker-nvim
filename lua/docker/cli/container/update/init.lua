local Command = require('docker.command')

---@type docker.cli.container.update.Opts
local _opts

return Command.new({ 'container', 'update' })
  :add_option({ name = 'blkio_weight', type = 'number' })
  :add_option({ name = 'cpu_period', type = 'number' })
  :add_option({ name = 'cpu_quota', type = 'number' })
  :add_option({ name = 'cpu_rt_period', type = 'number' })
  :add_option({ name = 'cpu_rt_runtime', type = 'number' })
  :add_option({ name = 'cpu_shares', type = 'number' })
  :add_option({ name = 'cpus', type = 'number' })
  :add_option({ name = 'cpuset_cpus', type = 'string' })
  :add_option({ name = 'cpuset_mems', type = 'string' })
  :add_option({ name = 'memory', type = 'bytes' })
  :add_option({ name = 'memory_reservation', type = 'bytes' })
  :add_option({ name = 'memory_swap', type = 'bytes' })
  :add_option({ name = 'pids_limit', type = 'number' })
  :add_option({ name = 'restart', type = 'string' })
  :build_with_args(_opts, { min = 1 })
