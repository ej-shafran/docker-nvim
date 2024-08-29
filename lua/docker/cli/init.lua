---@class docker.cli
local cli = {}

cli.container = require('docker.cli.container')
cli.image = require('docker.cli.image')

return cli
