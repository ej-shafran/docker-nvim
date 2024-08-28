local Command = require('docker.command')

---@type docker.cli.image.pull.Opts
local _opts

return Command.new({ 'image', 'pull' })
  :add_option('all_tags', 'boolean')
  :add_option('disable_content_trust', 'boolean')
  :add_option('platform', 'string')
  :add_option('quiet', 'boolean')
  :build_with_arg(_opts)
