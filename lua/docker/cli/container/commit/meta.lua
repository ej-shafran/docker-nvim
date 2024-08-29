---@meta _
error('Cannot require meta file')

---@class docker.cli.container.commit.Opts
---
---Author (e.g., "John Hannibal Smith <hannibal@a-team.com>")
---@field author? string
---
---Apply Dockerfile instruction to the created image
---@field change? string[]
---
---Commit message
---@field message? string
---
---Pause container during commit (default true)
---@field pause? boolean
