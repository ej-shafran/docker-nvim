---@meta _
error('Cannot require meta file')

---@alias docker.command.Serialize fun(name: string, value: unknown): string[]
---
---@alias docker.command.Validator fun(value: unknown, optional: boolean): vim.validate.Spec
---
---@alias docker.command.OptionType
---|"string"
---|"boolean"
---|"duration"
---|"bytes"
---|"number"
---|"record"
---|"portmap"
---|"host-to-ip"
