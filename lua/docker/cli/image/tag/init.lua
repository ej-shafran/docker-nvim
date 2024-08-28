local Command = require('docker.command')

---@param cmd string[]
---@param _ docker.cli.image.tag.Opts
local function tag_handler(cmd, _)
  local result = vim.system(cmd, { text = true }):wait()
  assert(result.code == 0, result.stderr)
end

return Command.new({ 'image', 'tag' }):build_with_args(tag_handler, { min = 2, max = 2 })
