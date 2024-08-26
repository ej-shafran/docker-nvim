---@alias docker.duration.Unit "us"|"ms"|"s"|"m"|"h"

---A representation of a certain duration of time.
---@class docker.Duration
---
---@field private _internal string
---@field private _us       number
local Duration = {}
Duration.__index = Duration

---@type table<docker.duration.Unit, number>
local unit_to_us = {
  us = 1,
  ms = 1000,
  s = 1000 * 1000,
  m = 1000 * 1000 * 60,
  h = 1000 * 1000 * 60 * 60,
}

---@private
---
---@param _internal string
---@param _us number
---@return docker.Duration
function Duration._new(_internal, _us)
  local obj = { _internal = _internal, _us = _us }
  setmetatable(obj, Duration)
  return obj
end

---Get a representation of a duration of time.
---
---@param init table<docker.duration.Unit, number>
---@return docker.Duration
function Duration.from(init)
  local init_lst = vim
    .iter(pairs(init))
    :map(function(unit, n)
      return Duration._new(('%d%s'):format(n, unit), unit_to_us[unit] * n)
    end)
    :totable()
  table.sort(init_lst, function(a, b)
    return a:greater_than(b)
  end)

  local _internal = vim
    .iter(init_lst)
    :map(function(d)
      return d._internal
    end)
    :join('')
  if _internal == '' then
    _internal = '0us'
  end

  local _us = vim
    .iter(init_lst)
    :map(function(d)
      return d._us
    end)
    :fold(0, function(acc, cur)
      return acc + cur
    end)

  return Duration._new(_internal, _us)
end

---Get the duration as a number of some unit.
---
---@param unit docker.duration.Unit
---@return number
function Duration:as(unit)
  return self._us / unit_to_us[unit]
end

---Get the `docker` CLI representation.
---
---@return string
function Duration:to_cli()
  return self._internal
end

---Compare two durations.
---
---@param other docker.Duration
---@return boolean is_greater whether `self` is greater than `other`
function Duration:greater_than(other)
  return self._us > other._us
end

return Duration
