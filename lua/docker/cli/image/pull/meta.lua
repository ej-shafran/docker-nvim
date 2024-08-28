---@meta _
error('Cannot require meta file')

---@class docker.cli.image.pull.Opts
---
---Download all tagged images in the repository
---@field all_tags? boolean
---
---Skip image verification (default true)
---@field disable_content_trust? boolean
---
---Set platform if server is multi-platform capable
---@field platform? string
---
---Suppress verbose output
---@field quiet? boolean
