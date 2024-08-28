---A builder for a `docker` CLI command function.
---
---Example (for `docker image ls`):
---
---```lua
--- local Command = require("docker.command")
---
--- ---@param cmd string[]
--- ---@param opts docker.image.ls.Opts
--- local function ls_handler(cmd, opts)
---   -- Call `vim.system()` here with `cmd`
--- end
---
--- local ls = Command.new({ 'image', 'ls', '--format', 'json' })
---    :add_option('all', 'boolean')
---    :add_option('digests', 'boolean')
---    :add_option('filter', 'record')
---    :build(ls_handler)
---
--- -- You can now call this function like:
--- ls { all = true }
--- ls { all = true, digests = true }
--- ls { filter = { { key = 'dangling', value = 'true' } } }
---```
---
---@class docker.Command
---
---@field private _command string[]
---@field private _arg_kind "fixed"|"variable"
---@field private _arg_count integer|{ max?: integer, min?: integer }
---@field private _options table<string, docker.command.Serialize>
---@field private _validators table<string, docker.command.Validator>
local Command = {}
Command.__index = Command

---Common serialization functions.
---@type table<docker.command.OptionType, docker.command.Serialize>
local type_to_serialize = {
  boolean = function(name)
    return { name }
  end,
  number = function(name, value)
    ---@cast value number
    return { name, tostring(value) }
  end,
  string = function(name, value)
    ---@cast value string
    return { name, value }
  end,
  duration = function(name, value)
    ---@cast value docker.Duration
    return { name, value:to_cli() }
  end,
  bytes = function(name, value)
    ---@cast value docker.Bytes
    return { name, value:to_cli() }
  end,
  record = function(name, value)
    ---@cast value table<string, string>
    local result = {}
    for record_key, record_value in pairs(value) do
      table.insert(result, name)
      table.insert(result, ('%s=%s'):format(record_key, record_value))
    end
    return result
  end,
  portmap = function(name, value)
    ---@cast value docker.PortMap
    return { name, ('%s:%s'):format(value.host_port, value.container_port) }
  end,
  ['host-to-ip'] = function(name, value)
    ---@cast value docker.HostToIP
    return { name, ('%s:%s'):format(value.host, value.ip) }
  end,
}

---Common validator functions.
---@type table<docker.command.OptionType, docker.command.Validator>
local type_to_validator = {
  boolean = function(value, optional)
    return { value, 'boolean', optional }
  end,
  number = function(value, optional)
    return { value, 'number', optional }
  end,
  string = function(value, optional)
    return { value, 'string', optional }
  end,
  duration = function(value, optional)
    return {
      value,
      function(val)
        if optional and val == nil then
          return true
        end

        return getmetatable(val) == require('docker.duration')
      end,
      'docker.Duration value',
    }
  end,
  bytes = function(value, optional)
    return {
      value,
      function(val)
        if optional and val == nil then
          return true
        end

        return getmetatable(val) == require('docker.bytes')
      end,
      'docker.Bytes value',
    }
  end,
  record = function(value, optional)
    return { value, 'table', optional }
  end,
  portmap = function(value, optional)
    return {
      value,
      function(val)
        if optional and val == nil then
          return true
        end

        if type(val) ~= 'table' then
          return false
        end

        return type(val.host_port) == 'string' and type(val.container_port) == 'string'
      end,
      'port mapping',
    }
  end,
  ['host-to-ip'] = function(value, optional)
    return {
      value,
      function(val)
        if optional and val == nil then
          return true
        end

        if type(val) ~= 'table' then
          return false
        end

        return type(val.ip) == 'string' and type(val.host) == 'string'
      end,
      'host-to-ip mapping',
    }
  end,
}

---@private
---
---@param _command string[]
---@return docker.Command
function Command._new(_command)
  ---@type docker.Command
  local obj = {
    _arg_kind = 'fixed',
    _arg_count = 0,
    _options = {},
    _command = _command,
    _validators = {},
  }
  setmetatable(obj, Command)
  return obj
end

---@private
---
---@param args string[]
---@param opts unknown
function Command:_validate(args, opts)
  if self._arg_kind == 'none' then
    assert(#args == 0)
  elseif self._arg_kind == 'one' then
    assert(#args == 1)
  end

  local spec = {}
  for key, validator in pairs(self._validators) do
    spec[key] = validator(opts[key], true)
  end
  vim.validate(spec)
end

---@private
---
---@param args string[]
---@param opts unknown
---@return string[]
function Command:_serialize(args, opts)
  local cmd = { 'docker' }
  for _, word in ipairs(self._command) do
    table.insert(cmd, word)
  end

  for key, value in pairs(opts) do
    local serialize = self._options[key]
    local serialized = serialize(('--%s'):format(key:gsub('_', '-')), value)
    for _, word in ipairs(serialized) do
      table.insert(cmd, word)
    end
  end

  for _, word in ipairs(args) do
    table.insert(cmd, word)
  end

  return cmd
end

---Initialize a `docker` CLI command function.
---
---@param command string[] the arguments to always append to `docker`; e.g. `{ 'image', 'ls', '--format', 'json' }`
---@return docker.Command
function Command.new(command)
  return Command._new(command)
end

---Add a new CLI option to this command.
---
---@param name string the name of the option; transformed when calling the CLI to turn "_" into "-"
---@param serialize docker.command.Serialize a function to transform this option's value to its CLI representation
---@param validator docker.command.Validator a function to validate this option's value
---@return docker.Command
function Command:add_custom_option(name, serialize, validator)
  self._options[name] = serialize
  self._validators[name] = validator
  return self
end

---Add a new CLI option to this command, with a well-known type.
---
---@param name string the name of the option; transformed when calling the CLI to turn "_" into "-"
---@param option_type docker.command.OptionType the type of value that makes sense for this option
---@return docker.Command
function Command:add_option(name, option_type)
  local serialize = type_to_serialize[option_type]
  local validator = type_to_validator[option_type]
  return self:add_custom_option(name, serialize, validator)
end

---Add a new CLI option to this command, whose type is some list.
---
---@param name string the name of the option; transformed when calling the CLI to turn "_" into "-"
---@param item_serialize docker.command.Serialize a function to transform each item of this option's value to its CLI representation
---@param item_validator docker.command.Validator a function to validate each item of this option's value
---@return docker.Command
function Command:add_custom_list_option(name, item_serialize, item_validator)
  ---@type docker.command.Serialize
  local function serialize(name_, value)
    ---@cast value unknown[]
    return vim
      .iter(value)
      :map(function(item)
        return item_serialize(name_, item)
      end)
      :flatten()
      :totable()
  end

  ---@type docker.command.Validator
  local function validator(value, optional)
    local item_spec = item_validator(nil, true)

    return {
      value,
      function(val)
        if optional and val == nil then
          return true
        end

        if type(val) ~= 'table' then
          return false
        end

        return vim.iter(val):all(function(item)
          local result = item_validator(item, false)
          local ok = pcall(vim.validate, { item = result })
          return ok
        end)
      end,
      ('list<%s>'):format(type(item_spec[2]) == 'string' and item_spec[2] or item_spec[3]),
    }
  end

  return self:add_custom_option(name, serialize, validator)
end

---Add a new CLI option to this command, whose type is a list of some well-known type.
---
---@param name string the name of the option; transformed when calling the CLI to turn "_" into "-"
---@param option_type docker.command.OptionType the type of value that makes sense for the items of this option
---@return docker.Command
function Command:add_list_option(name, option_type)
  local item_serialize = type_to_serialize[option_type]
  local item_validator = type_to_validator[option_type]
  return self:add_custom_list_option(name, item_serialize, item_validator)
end

---Get the final result as a function which only receives options.
---
---@generic T
---@generic O
---
---@param cb fun(cmd: string[], opts: O): T
---@return fun(opts?: O): T
function Command:build(cb)
  return function(opts_or_args, maybe_opts)
    local args
    local opts
    if self._arg_kind == 'fixed' then
      assert(self._arg_count == 0 or self._arg_count == 1)

      if self._arg_count == 0 then
        args = {}
        opts = opts_or_args
      elseif self._arg_count == 1 then
        args = { opts_or_args }
        opts = maybe_opts
      end
    else
      assert(type(self._arg_count) == 'table')

      args = opts_or_args
      opts = maybe_opts

      if self._arg_count.min then
        assert(
          #args > self._arg_count.min,
          ('invalid number of arguments; expected at least %d, got %d'):format(self._arg_count.min, #args)
        )
      end

      if self._arg_count.max then
        assert(
          #args <= self._arg_count.max,
          ('invalid number of arguments; expected at most %d, got %d'):format(self._arg_count.max, #args)
        )
      end
    end
    opts = opts or {}

    self:_validate(args, opts)

    local cmd = self:_serialize(args, opts)

    -- TODO: logging
    -- print(vim
    --   .iter(cmd)
    --   :map(function(word)
    --     if string.match(word, '%s+') ~= nil then
    --       return vim.fn.shellescape(word)
    --     end
    --     return word
    --   end)
    --   :join(' '))

    return cb and cb(cmd, opts) or cmd
  end
end

---Get the final result as a function which receives options and a single argument.
---
---@generic T
---@generic O
---
---@param cb fun(cmd: string[], opts: O): T
---@return fun(arg: string, opts?: O): T
function Command:build_with_arg(cb)
  self._arg_count = 1
  return self:build(cb)
end

---Get the final result as a function which receives options and a certain amount of arguments.
---
---@generic T
---@generic O
---
---@param cb fun(cmd: string[], opts: O): T
---@param count? { min?: integer, max?: integer }
---@return fun(args: string[], opts?: O): T
function Command:build_with_args(cb, count)
  self._arg_kind = 'variable'
  self._arg_count = count or {}
  return self:build(cb)
end

return Command
