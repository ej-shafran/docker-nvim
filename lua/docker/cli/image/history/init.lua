local Command = require('docker.command')

---@param cmd string[]
---@param opts docker.cli.image.history.Opts
local function history_handler(cmd, opts)
  local result = vim.system(cmd, { text = true }):wait()
  assert(result.code == 0, result.stderr)
  local stdout = assert(result.stdout)

  if opts.quiet then
    return stdout
  end

  ---@type docker.cli.image.History
  return vim.json.decode(stdout)
end

return Command.new({ 'image', 'history', '--format', 'json' })
  :add_option('human', 'boolean')
  :add_option('no_trunc', 'boolean')
  :add_option('quiet', 'boolean')
  :build_with_arg(history_handler)
