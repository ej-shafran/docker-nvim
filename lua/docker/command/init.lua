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
---    :add_option({ name = 'all', type = 'boolean' })
---    :add_option({ name = 'digests', type = 'boolean' })
---    :add_option({ name = 'filter', type = 'record' })
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
---@field private _command string
---@field private _args string[]
---@field private _arg_kind "fixed"|"variable"
---@field private _arg_count integer|{ max?: integer, min?: integer }
---@field private _options table<string, docker.command.Serialize>
---@field private _validators table<string, docker.command.Validator>
local Command = {}
Command.__index = Command

local Result = require('docker.command.result')

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
---@param _args string[]
---@param _command string
---@return docker.Command
function Command._new(_args, _command)
  ---@type docker.Command
  local obj = {
    _command = _command,
    _arg_kind = 'fixed',
    _arg_count = 0,
    _options = {},
    _args = _args,
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
  local cmd = { self._command }
  for _, word in ipairs(self._args) do
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
---@param args string[] the arguments to always append to `docker`; e.g. `{ 'image', 'ls', '--format', 'json' }`
---@return docker.Command
function Command.new(args)
  return Command._new(args, 'docker')
end

---Initialize a non-`docker` CLI command function.
---
---@param command string the command to run
---@param args string[] the arguments to append to the command
---@return docker.Command
function Command.non_docker(command, args)
  return Command._new(args, command)
end

---Add a CLI option to this command.
---
---@param opts docker.command.OptionOpts
---@return docker.Command
function Command:add_option(opts)
  local base_serialize
  local base_validator
  if opts.type then
    base_serialize = type_to_serialize[opts.type]
    base_validator = type_to_validator[opts.type]
  else
    base_serialize = opts.serialize
    base_validator = opts.validator
  end

  local serialize
  local validator
  if not opts.list then
    serialize = base_serialize
    validator = base_validator
  else
    serialize = function(name_, value)
      ---@cast value unknown[]
      return vim
        .iter(value)
        :map(function(item)
          return base_serialize(name_, item)
        end)
        :flatten()
        :totable()
    end
    validator = function(value, optional)
      local item_spec = base_validator(nil, true)

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
            local result = base_validator(item, false)
            local ok = pcall(vim.validate, { item = result })
            return ok
          end)
        end,
        ('list<%s>'):format(type(item_spec[2]) == 'string' and item_spec[2] or item_spec[3]),
      }
    end
  end

  self._options[opts.name] = serialize
  self._validators[opts.name] = validator
  return self
end

---Get the final result as a function which only receives options.
---
---@generic O
---
---@param _ O
---@return fun(opts?: O): docker.command.Result
function Command:build(_)
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
          #args >= self._arg_count.min,
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
    return Result.new(self:_serialize(args, opts))
  end
end

---Get the final result as a function which receives options and a single argument.
---
---@generic O
---
---@param _ O
---@return fun(arg: string, opts?: O): docker.command.Result
function Command:build_with_arg(_)
  self._arg_count = 1
  return self:build(_)
end

---Get the final result as a function which receives options and a certain amount of arguments.
---
---@generic O
---
---@param _ O
---@param count? { min?: integer, max?: integer }
---@return fun(args: string[], opts?: O): docker.command.Result
function Command:build_with_args(_, count)
  self._arg_kind = 'variable'
  self._arg_count = count or {}
  return self:build(_)
end

return Command
