local docker = require('docker')

describe('docker.hello', function()
  it('should return "hello"', function()
    assert.are.same(docker.hello(), 'hello')
  end)
end)
