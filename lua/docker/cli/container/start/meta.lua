---@meta _
error('Cannot require meta file')

---@class docker.cli.container.start.Opts
---
---Attach STDOUT/STDERR and forward signals
---@field attach? boolean
---
---Override the key sequence for detaching a container
---@field detach_keys? string
---
---Attach container's STDIN
---@field interactive? boolean
