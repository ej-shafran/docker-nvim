---@meta _
error('Cannot require meta file')

---@class docker.cli.image.push.Opts
---Push all tags of an image to the repository
---@field all_tags? boolean
---
---Skip image signing (default true)
---@field disable_content_trust?  boolean
---
---Suppress verbose output
---@field quiet? boolean
