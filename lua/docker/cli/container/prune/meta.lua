---@meta _
error('Cannot require meta file')

---@class docker.cli.container.prune.Opts
---
---Provide filter values (e.g. "until=<timestamp>")
---@field filter? table<string, string>
---
---Do not prompt for confirmation
---@field force? boolean
