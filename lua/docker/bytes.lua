---@alias docker.bytes.Unit "b"|"k"|"kb"|"m"|"mb"|"g"|"gb"

---A representation of an amount of bytes.
---@class docker.Bytes
---
---@field private _internal string
---@field private _b        number
local Bytes = {}
Bytes.__index = Bytes

---@type table<docker.bytes.Unit, number>
local unit_to_b = {
  b = 1,
  k = 1024,
  kb = 1024,
  m = 1024 * 1024,
  mb = 1024 * 1024,
  g = 1024 * 1024 * 1024,
  gb = 1024 * 1024 * 1024,
}

---@private
---
---@param _internal string
---@param _b number
---@return docker.Bytes
function Bytes._new(_internal, _b)
  local obj = { _internal = _internal, _b = _b }
  setmetatable(obj, Bytes)
  return obj
end

---Get a representation of bytes.
---
---@param init table<docker.bytes.Unit, number>
---@return docker.Bytes
function Bytes.from(init)
  local smallest_unit = vim.iter(pairs(init)):fold('gb', function(acc, unit)
    return unit_to_b[unit] < unit_to_b[acc] and unit or acc
  end)

  local _b = vim.iter(pairs(init)):fold(0, function(acc, unit, n)
    return acc + (unit_to_b[unit] * n)
  end)
  if _b == 0 then
    smallest_unit = 'b'
  end

  local _internal = ('%d%s'):format(_b / unit_to_b[smallest_unit], smallest_unit)

  return Bytes._new(_internal, _b)
end

---Get the bytes as a number of some unit.
---
---@param unit docker.bytes.Unit
---@return number
function Bytes:as(unit)
  return self._b / unit_to_b[unit]
end

---Get the `docker` CLI representation.
---
---@return string
function Bytes:to_cli()
  return self._internal
end

---Compare two amounts of bytes.
---
---@param other docker.Bytes
---@return boolean is_greater whether `self` is greater than `other`
function Bytes:greater_than(other)
  return self._b > other._b
end

return Bytes
