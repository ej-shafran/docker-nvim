local Command = require('docker.command')

---@type docker.cli.container.update.Opts
local _opts

return Command.new({ 'container', 'update' })
  :add_option('blkio_weight', 'number')
  :add_option('cpu_period', 'number')
  :add_option('cpu_quota', 'number')
  :add_option('cpu_rt_period', 'number')
  :add_option('cpu_rt_runtime', 'number')
  :add_option('cpu_shares', 'number')
  :add_option('cpus', 'number')
  :add_option('cpuset_cpus', 'string')
  :add_option('cpuset_mems', 'string')
  :add_option('memory', 'bytes')
  :add_option('memory_reservation', 'bytes')
  :add_option('memory_swap', 'bytes')
  :add_option('pids_limit', 'number')
  :add_option('restart', 'string')
  :build_with_args(_opts, { min = 1 })
