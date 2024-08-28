---@meta _
error('Cannot require meta file')

---Options for `docker image ls`
---@class docker.cli.image.ls.Opts
---
---Show all images (default hides intermediate images)
---@field all?     boolean
---
---Show digests
---@field digests? boolean
---
---Filter output based on conditions provided
---@field filter?  table<string, string>
