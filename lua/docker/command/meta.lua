---@meta _
error('Cannot require meta file')

---@alias docker.command.Serialize fun(name: string, value: unknown): string[]

---@alias docker.command.Validator fun(value: unknown, optional: boolean): vim.validate.Spec

---@alias docker.command.OptionType
---|"string"
---|"boolean"
---|"duration"
---|"bytes"
---|"number"
---|"record"
---|"portmap"
---|"host-to-ip"

---@class docker.command.CommonOptionOpts
---
---@field name string
---@field list? boolean

---@class (exact) docker.command.WellKnownOptionOpts : docker.command.CommonOptionOpts
---
---@field type docker.command.OptionType

---@class (exact) docker.command.CustomOptionOpts : docker.command.CommonOptionOpts
---
---@field serialize docker.command.Serialize
---@field validator docker.command.Validator

---@alias docker.command.OptionOpts
---|docker.command.WellKnownOptionOpts
---|docker.command.CustomOptionOpts
