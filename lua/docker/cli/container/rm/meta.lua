---@meta _
error('Cannot require meta file')

---@class docker.cli.container.rm.Opts
---
---Force the removal of a running container (uses SIGKILL)
---@field force?     boolean
---
---Remove the specified link
---@field link?      boolean
---
---Remove anonymous volumes associated with the container
---@field volumes?   boolean
