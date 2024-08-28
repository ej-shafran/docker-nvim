local container = {}

local Command = require('docker.command')

---@param cmd string[]
---@param _ docker.container.ls.Opts
local function ls_handler(cmd, _)
  local result = vim.system(cmd, { text = true }):wait()
  assert(result.code == 0, result.stderr)
  local stdout = assert(result.stdout)
  local lines = vim.split(stdout, '\n')
  ---@type docker.container.Summary[]
  return vim
    .iter(lines)
    :filter(function(line)
      return line ~= ''
    end)
    :map(vim.json.decode)
    :totable()
end

container.ls = Command.new({ 'container', 'ls', '--format', 'json' })
  :add_option('all', 'boolean')
  :add_option('size', 'boolean')
  :add_option('latest', 'boolean')
  :add_option('last', 'number')
  :add_option('filter', 'record')
  :build(ls_handler)

---@param cmd string[]
---@param opts docker.container.run.Opts
local function run_handler(cmd, opts)
  if opts.tty then
    vim.cmd(('edit term://%s'):format(vim.fn.join(cmd)))
    return
  end

  return vim.system(cmd, {
    text = opts.detach,
  })
end

container.run = Command.new({ 'container', 'run' })
  :add_list_option('add_host', 'host-to-ip')
  :add_list_option('attach', 'string')
  :add_list_option('blkio_weight_device', 'string')
  :add_list_option('cap_add', 'string')
  :add_list_option('cap_drop', 'string')
  :add_list_option('device', 'string')
  :add_list_option('device_cgroup_rule', 'string')
  :add_list_option('device_read_bps', 'string')
  :add_list_option('device_read_iops', 'string')
  :add_list_option('device_write_bps', 'string')
  :add_list_option('device_write_iops', 'string')
  :add_list_option('dns', 'string')
  :add_list_option('dns_option', 'string')
  :add_list_option('dns_search', 'string')
  :add_list_option('env_file', 'string')
  :add_list_option('expose', 'string')
  :add_list_option('gpus', 'string')
  :add_list_option('group_add', 'string')
  :add_list_option('label', 'string')
  :add_list_option('label_file', 'string')
  :add_list_option('link', 'string')
  :add_list_option('link_local_ip', 'string')
  :add_list_option('log_opt', 'string')
  :add_list_option('publish', 'portmap')
  :add_list_option('security_opt', 'string')
  :add_list_option('storage_opt', 'string')
  :add_list_option('sysctl', 'string')
  :add_list_option('tmpfs', 'string')
  :add_list_option('ulimit', 'string')
  :add_list_option('volume', 'string')
  :add_list_option('volumes_from', 'string')
  :add_option('blkio_weight', 'number')
  :add_option('cgroup_parent', 'string')
  :add_option('cgroupns', 'string')
  :add_option('cidfile', 'string')
  :add_option('cpu_period', 'number')
  :add_option('cpu_quota', 'number')
  :add_option('cpu_rt_period', 'number')
  :add_option('cpu_rt_runtime', 'number')
  :add_option('cpu_shares', 'number')
  :add_option('cpus', 'number')
  :add_option('cpuset_cpus', 'string')
  :add_option('cpuset_mems', 'string')
  :add_option('detach', 'boolean')
  :add_option('detach_keys', 'string')
  :add_option('disable_content_trust', 'boolean')
  :add_option('domainname', 'string')
  :add_option('entrypoint', 'string')
  :add_option('env', 'record')
  :add_option('health_cmd', 'string')
  :add_option('health_interval', 'duration')
  :add_option('health_retries', 'number')
  :add_option('health_start_period', 'duration')
  :add_option('health_timeout', 'duration')
  :add_option('hostname', 'string')
  :add_option('init', 'boolean')
  :add_option('interactive', 'boolean')
  :add_option('ip', 'string')
  :add_option('ip6', 'string')
  :add_option('ipc', 'string')
  :add_option('isolation', 'string')
  :add_option('kernel_memory', 'bytes')
  :add_option('log_driver', 'string')
  :add_option('mac_address', 'string')
  :add_option('memory', 'bytes')
  :add_option('memory_reservation', 'bytes')
  :add_option('memory_swap', 'bytes')
  :add_option('memory_swappiness', 'number')
  :add_option('mount', 'string')
  :add_option('name', 'string')
  :add_option('network', 'string')
  :add_option('network_alias', 'string')
  :add_option('no_healthcheck', 'boolean')
  :add_option('oom_kill_disable', 'boolean')
  :add_option('oom_score_adj', 'number')
  :add_option('pid', 'string')
  :add_option('pids_limit', 'number')
  :add_option('platform', 'string')
  :add_option('privileged', 'boolean')
  :add_option('publish_all', 'boolean')
  :add_option('pull', 'string')
  :add_option('quiet', 'boolean')
  :add_option('read_only', 'boolean')
  :add_option('restart', 'string')
  :add_option('rm', 'boolean')
  :add_option('runtime', 'string')
  :add_option('shm_size', 'bytes')
  :add_option('sig_proxy', 'boolean')
  :add_option('stop_signal', 'string')
  :add_option('stop_timeout', 'number')
  :add_option('tty', 'boolean')
  :add_option('user', 'string')
  :add_option('userns', 'string')
  :add_option('uts', 'string')
  :add_option('volume_driver', 'string')
  :add_option('workdir', 'string')
  :build_with_arg(run_handler)

---@param cmd string[]
---@param _ docker.container.attach.Opts
local function attach_handler(cmd, _)
  vim.cmd(('edit term://%s'):format(vim.fn.join(cmd)))
end

container.attach = Command.new({ 'container', 'attach' })
  :add_option('detach_keys', 'string')
  :add_option('no_stdin', 'boolean')
  :add_option('sig_proxy', 'boolean')
  :build_with_arg(attach_handler)

---@param cmd string[]
---@param _ docker.container.stop.Opts
local function stop_handler(cmd, _)
  local result = vim.system(cmd, { text = true }):wait()
  assert(result.code == 0, result.stderr)
end

container.stop = Command.new({ 'container', 'stop' })
  :add_option('signal', 'string')
  :add_option('time', 'number')
  :build_with_args(stop_handler)

return container
