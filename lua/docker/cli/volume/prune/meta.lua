---@meta _
error('Cannot require meta file')

---@class docker.cli.volume.prune.Opts
---
---Remove all unused volumes, not just anonymous ones
---@field all? boolean
---
---Provide filter values (e.g. "label=<label>")
---@field filter? table<string, string>
