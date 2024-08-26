local docker = require('docker')

describe('Bytes.from', function()
  it('should represent an amount of bytes', function()
    local examples = {
      { docker.Bytes.from {}, '0b', 0 },
      { docker.Bytes.from { kb = 1 }, '1kb', 1024 },
      { docker.Bytes.from { kb = 1, b = 30 }, '1054b', 1054 },
    }

    for _, example in pairs(examples) do
      assert.are_same(example[1]:to_cli(), example[2])
      assert.are_same(example[1]:as('b'), example[3])
    end
  end)
end)
