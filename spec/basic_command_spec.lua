local docker = require('docker')

local function json_serialize(_, value)
  return { vim.json.encode(value) .. '\n' }
end

local function json_validator(value, _)
  return { value, { 'table', 'string', 'number', 'nil', 'boolean' } }
end

describe('Command.non_docker', function()
  it('should create a wrapper for CLI commands', function()
    local base_command = 'echo'
    local base_args = {}
    local echo = docker.Command.non_docker(base_command, base_args):build_with_args(nil)

    local cmd_args = { 'hello', 'world' }
    local result = echo(cmd_args)
    assert.are_same(result.cmd[1], base_command)
    assert.are_same(vim.list_slice(result.cmd, 2, #result.cmd), cmd_args)

    local stdout = echo(cmd_args):call_sync()
    assert.are_same(stdout, vim.fn.join(cmd_args) .. '\n')
  end)

  it('should handle commands that return JSON', function()
    local base_command = 'echo'
    local base_args = {}
    ---@type { json?: unknown }
    local _opts
    local echo_json = docker.Command
      .non_docker(base_command, base_args)
      :add_option({
        name = 'json',
        serialize = json_serialize,
        validator = json_validator,
      })
      :build(_opts)

    local json = { hello = 'world', goodbye = 20 }
    local result = echo_json { json = json }
    assert.are_same(result:get_json(), json)
  end)

  it('should handle commands that return lines of JSON', function()
    local base_command = 'echo'
    local base_args = {}
    ---@type { json?: unknown[] }
    local _opts
    local echo_json_lines = docker.Command
      .non_docker(base_command, base_args)
      :add_option({
        name = 'json',
        list = true,
        serialize = json_serialize,
        validator = json_validator,
      })
      :build(_opts)

    local json = {
      { hello = 'world', goodbye = 0 },
      { hello = 'world', goodbye = 10 },
      { hello = 'world', goodbye = 20 },
    }
    local result = echo_json_lines { json = json }
    assert.are_same(result:get_json_lines(), json)
  end)
end)
