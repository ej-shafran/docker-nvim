---@meta _
error('Cannot require meta file')

---@class docker.cli.volume.inspect.Opts
---
---Format output using a custom template:
---'json':             Print in JSON format
---'TEMPLATE':         Print output using the given Go template. Refer to https://docs.docker.com/go/formatting/ for more information about formatting output with templates
---@field format? string
