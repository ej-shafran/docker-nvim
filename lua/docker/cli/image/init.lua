local image = {}

image.build = require('docker.cli.image.build')
image.history = require('docker.cli.image.history')
image.import = require('docker.cli.image.import')
image.inspect = require('docker.cli.image.inspect')
image.load = require('docker.cli.image.load')
image.ls = require('docker.cli.image.ls')
image.prune = require('docker.cli.image.prune')
image.pull = require('docker.cli.image.pull')
image.push = require('docker.cli.image.push')
image.save = require('docker.cli.image.save')
image.rm = require('docker.cli.image.rm')

return image
