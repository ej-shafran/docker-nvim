---@meta _
error('Cannot require meta file')

---@class docker.cli.container.attach.Opts
---
---Override the key sequence for detaching a container
---@field detach_keys? string
---
---Do not attach STDIN
---@field no_stdin?    boolean
---
---Proxy all received signals to the process
---@field sig_proxy?   boolean
