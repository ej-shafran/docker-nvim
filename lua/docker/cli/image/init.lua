local image = {}

image.build = require('docker.cli.image.build')
image.ls = require('docker.cli.image.ls')
image.rm = require('docker.cli.image.rm')

return image
