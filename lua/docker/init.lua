local docker = {}

docker.Duration = require('docker.duration')
docker.Bytes = require('docker.bytes')

docker.cli = {}
docker.cli.image = require('docker.image.cli')
docker.cli.container = require('docker.container.cli')

return docker
