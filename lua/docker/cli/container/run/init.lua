local Command = require('docker.command')

---@type docker.cli.container.run.Opts
local _opts

return Command.new({ 'container', 'run' })
  :add_option({ name = 'add_host', type = 'host-to-ip', list = true })
  :add_option({ name = 'attach', type = 'string', list = true })
  :add_option({ name = 'blkio_weight_device', type = 'string', list = true })
  :add_option({ name = 'cap_add', type = 'string', list = true })
  :add_option({ name = 'cap_drop', type = 'string', list = true })
  :add_option({ name = 'device', type = 'string', list = true })
  :add_option({ name = 'device_cgroup_rule', type = 'string', list = true })
  :add_option({ name = 'device_read_bps', type = 'string', list = true })
  :add_option({ name = 'device_read_iops', type = 'string', list = true })
  :add_option({ name = 'device_write_bps', type = 'string', list = true })
  :add_option({ name = 'device_write_iops', type = 'string', list = true })
  :add_option({ name = 'dns', type = 'string', list = true })
  :add_option({ name = 'dns_option', type = 'string', list = true })
  :add_option({ name = 'dns_search', type = 'string', list = true })
  :add_option({ name = 'env_file', type = 'string', list = true })
  :add_option({ name = 'expose', type = 'string', list = true })
  :add_option({ name = 'gpus', type = 'string', list = true })
  :add_option({ name = 'group_add', type = 'string', list = true })
  :add_option({ name = 'label', type = 'string', list = true })
  :add_option({ name = 'label_file', type = 'string', list = true })
  :add_option({ name = 'link', type = 'string', list = true })
  :add_option({ name = 'link_local_ip', type = 'string', list = true })
  :add_option({ name = 'log_opt', type = 'string', list = true })
  :add_option({ name = 'publish', type = 'portmap', list = true })
  :add_option({ name = 'security_opt', type = 'string', list = true })
  :add_option({ name = 'storage_opt', type = 'string', list = true })
  :add_option({ name = 'sysctl', type = 'string', list = true })
  :add_option({ name = 'tmpfs', type = 'string', list = true })
  :add_option({ name = 'ulimit', type = 'string', list = true })
  :add_option({ name = 'volume', type = 'string', list = true })
  :add_option({ name = 'volumes_from', type = 'string', list = true })
  :add_option({ name = 'blkio_weight', type = 'number' })
  :add_option({ name = 'cgroup_parent', type = 'string' })
  :add_option({ name = 'cgroupns', type = 'string' })
  :add_option({ name = 'cidfile', type = 'string' })
  :add_option({ name = 'cpu_period', type = 'number' })
  :add_option({ name = 'cpu_quota', type = 'number' })
  :add_option({ name = 'cpu_rt_period', type = 'number' })
  :add_option({ name = 'cpu_rt_runtime', type = 'number' })
  :add_option({ name = 'cpu_shares', type = 'number' })
  :add_option({ name = 'cpus', type = 'number' })
  :add_option({ name = 'cpuset_cpus', type = 'string' })
  :add_option({ name = 'cpuset_mems', type = 'string' })
  :add_option({ name = 'detach', type = 'boolean' })
  :add_option({ name = 'detach_keys', type = 'string' })
  :add_option({ name = 'disable_content_trust', type = 'boolean' })
  :add_option({ name = 'domainname', type = 'string' })
  :add_option({ name = 'entrypoint', type = 'string' })
  :add_option({ name = 'env', type = 'record' })
  :add_option({ name = 'health_cmd', type = 'string' })
  :add_option({ name = 'health_interval', type = 'duration' })
  :add_option({ name = 'health_retries', type = 'number' })
  :add_option({ name = 'health_start_period', type = 'duration' })
  :add_option({ name = 'health_timeout', type = 'duration' })
  :add_option({ name = 'hostname', type = 'string' })
  :add_option({ name = 'init', type = 'boolean' })
  :add_option({ name = 'interactive', type = 'boolean' })
  :add_option({ name = 'ip', type = 'string' })
  :add_option({ name = 'ip6', type = 'string' })
  :add_option({ name = 'ipc', type = 'string' })
  :add_option({ name = 'isolation', type = 'string' })
  :add_option({ name = 'kernel_memory', type = 'bytes' })
  :add_option({ name = 'log_driver', type = 'string' })
  :add_option({ name = 'mac_address', type = 'string' })
  :add_option({ name = 'memory', type = 'bytes' })
  :add_option({ name = 'memory_reservation', type = 'bytes' })
  :add_option({ name = 'memory_swap', type = 'bytes' })
  :add_option({ name = 'memory_swappiness', type = 'number' })
  :add_option({ name = 'mount', type = 'string' })
  :add_option({ name = 'name', type = 'string' })
  :add_option({ name = 'network', type = 'string' })
  :add_option({ name = 'network_alias', type = 'string' })
  :add_option({ name = 'no_healthcheck', type = 'boolean' })
  :add_option({ name = 'oom_kill_disable', type = 'boolean' })
  :add_option({ name = 'oom_score_adj', type = 'number' })
  :add_option({ name = 'pid', type = 'string' })
  :add_option({ name = 'pids_limit', type = 'number' })
  :add_option({ name = 'platform', type = 'string' })
  :add_option({ name = 'privileged', type = 'boolean' })
  :add_option({ name = 'publish_all', type = 'boolean' })
  :add_option({ name = 'pull', type = 'string' })
  :add_option({ name = 'quiet', type = 'boolean' })
  :add_option({ name = 'read_only', type = 'boolean' })
  :add_option({ name = 'restart', type = 'string' })
  :add_option({ name = 'rm', type = 'boolean' })
  :add_option({ name = 'runtime', type = 'string' })
  :add_option({ name = 'shm_size', type = 'bytes' })
  :add_option({ name = 'sig_proxy', type = 'boolean' })
  :add_option({ name = 'stop_signal', type = 'string' })
  :add_option({ name = 'stop_timeout', type = 'number' })
  :add_option({ name = 'tty', type = 'boolean' })
  :add_option({ name = 'user', type = 'string' })
  :add_option({ name = 'userns', type = 'string' })
  :add_option({ name = 'uts', type = 'string' })
  :add_option({ name = 'volume_driver', type = 'string' })
  :add_option({ name = 'workdir', type = 'string' })
  :build_with_args(_opts, { min = 1 })
