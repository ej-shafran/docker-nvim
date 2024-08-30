local Command = require('docker.command')

---@type docker.cli.image.push.Opts
local _opts

return Command.new({ 'image', 'push' })
  :add_option({ name = 'all_tags', type = 'boolean' })
  :add_option({ name = 'disable_content_trust', type = 'boolean' })
  :add_option({ name = 'quiet', type = 'boolean' })
  :build_with_arg(_opts)
