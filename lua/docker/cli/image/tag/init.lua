local Command = require('docker.command')

---@type docker.cli.image.tag.Opts
local _opts

return Command.new({ 'image', 'tag' }):build_with_args(_opts, { min = 2, max = 2 })
