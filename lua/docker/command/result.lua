---@class docker.command.Result
---
---@field cmd string[]
local Result = {}
Result.__index = Result

---@private
---
---@param cmd string[]
---@return docker.command.Result result
function Result._new(cmd)
  local obj = { cmd = cmd }
  setmetatable(obj, Result)
  return obj
end

---@param cmd string[]
---@return docker.command.Result result
function Result.new(cmd)
  return Result._new(cmd)
end

---@param opts? vim.SystemOpts
---@param on_exit? fun(out: vim.SystemCompleted)
---@return vim.SystemObj system
function Result:call(opts, on_exit)
  return vim.system(self.cmd, opts, on_exit)
end

---@return string stdout
function Result:call_sync()
  local system = self:call({ text = true }):wait()
  assert(system.code == 0, system.stderr)
  return assert(system.stdout)
end

---@return unknown
function Result:get_json()
  local stdout = self:call_sync()
  return vim.json.decode(stdout)
end

---@return unknown[]
function Result:get_json_lines()
  local stdout = self:call_sync()
  local lines = vim.split(stdout, '\n')
  return vim
    .iter(lines)
    :filter(function(line)
      return line ~= ''
    end)
    :map(vim.json.decode)
    :totable()
end

---@param opts? vim.api.keyset.cmd
function Result:in_terminal(opts)
  opts = opts or {}
  vim.cmd(vim.tbl_extend('error', opts, {
    cmd = 'edit',
    args = { ('term://%s'):format(vim.fn.join(self.cmd)) },
  }))
end

---@return string
function Result:tostring()
  return vim
    .iter(self.cmd)
    :map(function(word)
      if string.match(word, '%s+') ~= nil then
        return vim.fn.shellescape(word)
      end
      return word
    end)
    :join(' ')
end

---@param logger? fun(cmd: string)
---@return docker.command.Result
function Result:log(logger)
  logger = logger or print
  logger(self:tostring())
  return self
end

return Result
