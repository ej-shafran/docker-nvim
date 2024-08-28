local image = {}

local Command = require('docker.command')

---@param cmd string[]
---@param _ docker.image.ls.Opts
local function ls_handler(cmd, _)
  local result = vim.system(cmd, { text = true }):wait()
  assert(result.code == 0, result.stderr)
  local stdout = assert(result.stdout)
  local lines = vim.split(stdout, '\n')
  ---@type docker.image.Summary[]
  return vim
    .iter(lines)
    :filter(function(line)
      return line ~= ''
    end)
    :map(vim.json.decode)
    :totable()
end

image.ls = Command.new({ 'image', 'ls', '--format', 'json' })
  :add_option('all', 'boolean')
  :add_option('digests', 'boolean')
  :add_option('filter', 'record')
  :build(ls_handler)

---@param cmd string[]
---@param opts docker.image.build.Opts
local function build_handler(cmd, opts)
  return vim.system(cmd, {
    text = opts.quiet,
  })
end

image.build = Command.new({ 'image', 'build' })
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

---@param cmd string[]
---@param _ docker.image.rm.Opts
local function rm_handler(cmd, _)
  local result = vim.system(cmd, { text = true }):wait()
  assert(result.code == 0, result.stderr)
end

image.rm = Command.new({ 'image', 'rm' })
  :add_option('force', 'boolean')
  :add_option('no_prune', 'boolean')
  :build_with_args(rm_handler)

return image
