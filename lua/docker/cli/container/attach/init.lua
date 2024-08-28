local Command = require('docker.command')

---@param cmd string[]
---@param _ docker.cli.container.attach.Opts
local function attach_handler(cmd, _)
  vim.cmd(('edit term://%s'):format(vim.fn.join(cmd)))
end

return Command.new({ 'container', 'attach' })
  :add_option('detach_keys', 'string')
  :add_option('no_stdin', 'boolean')
  :add_option('sig_proxy', 'boolean')
  :build_with_arg(attach_handler)
