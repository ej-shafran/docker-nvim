---@meta _
error('Cannot require meta file')

---@class docker.cli.container.stats.Opts
---
---Show all containers (default shows just running)
---@field all? boolean
---
---Format output using a custom template:
---'table':            Print output in table format with column headers (default)
---'table TEMPLATE':   Print output in table format using the given Go template
---'json':             Print in JSON format
---'TEMPLATE':         Print output using the given Go template. Refer to https://docs.docker.com/go/formatting/ for more information about formatting output with templates
---@field format? string
---
---Disable streaming stats and only pull the first result
---@field no_stream? boolean
---
---Do not truncate output
---@field no_trunc? boolean
