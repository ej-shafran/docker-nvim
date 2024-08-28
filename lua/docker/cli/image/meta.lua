---@meta _
error('Cannot require meta file')

---A summary of a docker image, returned by `docker image ls`.
---@class docker.cli.image.Summary
---
---Image ID
---@field ID           string
---
---Image repository
---@field Repository   string
---
---Image tag
---@field Tag          string
---
---Image digest
---@field Digest       string
---
---Elapsed time since the image was created
---@field CreatedSince string
---
---Time when the image was created
---@field CreatedAt    string
---
---Image disk size
---@field Size         string
