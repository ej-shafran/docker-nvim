local Command = require('docker.command')

---@param cmd string[]
---@param _ docker.cli.image.ls.Opts
local function ls_handler(cmd, _)
  local result = vim.system(cmd, { text = true }):wait()
  assert(result.code == 0, result.stderr)
  local stdout = assert(result.stdout)
  local lines = vim.split(stdout, '\n')
  ---@type docker.cli.image.Summary[]
  return vim
    .iter(lines)
    :filter(function(line)
      return line ~= ''
    end)
    :map(vim.json.decode)
    :totable()
end

return Command.new({ 'image', 'ls', '--format', 'json' })
  :add_option('all', 'boolean')
  :add_option('digests', 'boolean')
  :add_option('filter', 'record')
  :build(ls_handler)
