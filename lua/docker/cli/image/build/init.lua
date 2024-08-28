local Command = require('docker.command')

---@param cmd string[]
---@param opts docker.cli.image.build.Opts
local function build_handler(cmd, opts)
  return vim.system(cmd, {
    text = opts.quiet,
  })
end

return Command.new({ 'image', 'build' })
  :add_list_option('allow', 'string')
  :add_list_option('attest', 'string')
  :add_list_option('build_arg', 'string')
  :add_list_option('cache_from', 'string')
  :add_list_option('cache_to', 'string')
  :add_list_option('label', 'string')
  :add_list_option('no_cache_filter', 'string')
  :add_list_option('output', 'string')
  :add_list_option('platform', 'string')
  :add_list_option('secret', 'string')
  :add_list_option('ssh', 'string')
  :add_list_option('tag', 'string')
  :add_list_option('ulimit', 'string')
  :add_option('build_context', 'record')
  :add_option('builder', 'string')
  :add_option('cgroup_parent', 'string')
  :add_option('file', 'string')
  :add_option('iidfile', 'string')
  :add_option('metadata_file', 'string')
  :add_option('network', 'string')
  :add_option('no_cache', 'boolean')
  :add_option('pull', 'boolean')
  :add_option('quiet', 'boolean')
  :add_option('shm_size', 'bytes')
  :add_option('target', 'string')
  :build_with_arg(build_handler)
