---@class docker.cli
local cli = {}

cli.container = require('docker.cli.container')
cli.image = require('docker.cli.image')
cli.volume = require('docker.cli.volume')

return cli
