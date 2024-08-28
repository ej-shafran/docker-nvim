local Command = require('docker.command')

---@param cmd string[]
---@param _ docker.cli.image.save.Opts
local function save_handler(cmd, _)
  local result = vim.system(cmd, { text = true }):wait()
  assert(result.code == 0, result.stderr)
  return result.stdout
end

return Command.new({ 'image', 'save' }):add_option('output', 'string'):build_with_args(save_handler, { min = 1 })
