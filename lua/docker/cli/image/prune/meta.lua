---@meta _
error('Cannot require meta file')

---@class docker.cli.image.prune.Opts
---
---Remove all unused images, not just dangling ones
---@field all? boolean
---
---Provide filter values (e.g. "until=<timestamp>")
---@field filter? table<string, string>
---
---Do not prompt for confirmation
---@field force? boolean
