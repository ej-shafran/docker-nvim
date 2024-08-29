---@meta _
error('Cannot require meta file')

---@class docker.cli.volume.create.Opts
---
---Specify volume driver name (default "local")
---@field driver? string
---
---Set metadata for a volume
---@field label? string[]
---
---Set driver specific options (default map[])
---@field opt? string[]
