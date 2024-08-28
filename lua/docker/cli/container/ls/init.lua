local Command = require('docker.command')

---@param cmd string[]
---@param _ docker.cli.container.ls.Opts
local function ls_handler(cmd, _)
  local result = vim.system(cmd, { text = true }):wait()
  assert(result.code == 0, result.stderr)
  local stdout = assert(result.stdout)
  local lines = vim.split(stdout, '\n')
  ---@type docker.cli.container.Summary[]
  return vim
    .iter(lines)
    :filter(function(line)
      return line ~= ''
    end)
    :map(vim.json.decode)
    :totable()
end

return Command.new({ 'container', 'ls', '--format', 'json' })
  :add_option('all', 'boolean')
  :add_option('size', 'boolean')
  :add_option('latest', 'boolean')
  :add_option('last', 'number')
  :add_option('filter', 'record')
  :build(ls_handler)
