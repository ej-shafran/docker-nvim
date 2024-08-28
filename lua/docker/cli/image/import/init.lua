local Command = require('docker.command')

---@param cmd string[]
---@param _ docker.cli.image.import.Opts
local function import_handler(cmd, _)
  local result = vim.system(cmd, { text = true }):wait()
  assert(result.code == 0, result.stderr)
end

return Command.new({ 'image', 'import' })
  :add_list_option('change', 'string')
  :add_option('message', 'string')
  :add_option('platform', 'string')
  :build_with_args(import_handler, { min = 1, max = 2 })
