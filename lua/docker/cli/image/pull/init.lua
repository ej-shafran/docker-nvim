local Command = require('docker.command')

---@param cmd string[]
---@param _ docker.cli.image.pull.Opts
local function pull_handler(cmd, _)
  local result = vim.system(cmd, { text = true }):wait()
  assert(result.code == 0, result.stderr)
end

return Command.new({ 'image', 'pull' })
  :add_option('all_tags', 'boolean')
  :add_option('disable_content_trust', 'boolean')
  :add_option('platform', 'string')
  :add_option('quiet', 'boolean')
  :build_with_arg(pull_handler)
