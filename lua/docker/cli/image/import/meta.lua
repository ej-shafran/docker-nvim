---@meta _
error('Cannot require meta file')

---@class docker.cli.image.import.Opts
---
---Apply Dockerfile instruction to the created image
---@field change? string[]
---
---Set commit message for imported image
---@field message? string
---
---Set platform if server is multi-platform capable
---@field platform? string
