local docker = require('docker')

describe('Duration.from', function()
  it('should represent a certain duration', function()
    local examples = {
      { docker.Duration.from {}, '0us', 0 },
      { docker.Duration.from { ms = 300 }, '300ms', 300 },
      { docker.Duration.from { m = 1, s = 30 }, '1m30s', 90000 },
    }

    for _, example in ipairs(examples) do
      assert.are_same(example[1]:to_cli(), example[2])
      assert.are_same(example[1]:as('ms'), example[3])
    end
  end)
end)
