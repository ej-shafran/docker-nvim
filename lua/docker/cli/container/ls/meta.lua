---@meta _
error('Cannot require meta file')

---Options for `docker container ls`
---@class docker.cli.container.ls.Opts
---
---Show all containers (default shows just running)
---@field all?    boolean
---
---Filter output based on conditions provided
---@field filter? table<string, string>
---
---Show n last created containers (includes all states)
---@field last?   integer
---
---Show the latest created container (includes all states)
---@field latest? boolean
---
---Display total file sizes
---@field size?   boolean
