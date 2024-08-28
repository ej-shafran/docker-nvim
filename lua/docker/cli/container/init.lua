local container = {}

container.attach = require('docker.cli.container.attach')
container.ls = require('docker.cli.container.ls')
container.run = require('docker.cli.container.run')
container.stop = require('docker.cli.container.stop')

return container
