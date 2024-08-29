---@meta _
error('Cannot require meta file')

---@class docker.cli.container.cp.Opts
---
---Archive mode (copy all uid/gid information)
---@field archive? boolean
---
---Always follow symbol link in SRC_PATH
---@field follow_link? boolean
---
---Suppress progress output during copy. Progress output is automatically suppressed if no terminal is attached
---@field quiet? boolean
