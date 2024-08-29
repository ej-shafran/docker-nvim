---@meta _
error('Cannot require meta file')

---@class docker.cli.volume.ls.Opts
---
---Provide filter values (e.g. "dangling=true")
---@field filter? table<string,string>
---
---Format output using a custom template:
---'table':            Print output in table format with column headers (default)
---'table TEMPLATE':   Print output in table format using the given Go template
---'json':             Print in JSON format
---'TEMPLATE':         Print output using the given Go template. Refer to https://docs.docker.com/go/formatting/ for more information about formatting output with templates
---@field format? string
---
---Only display volume names
---@field quiet? boolean
