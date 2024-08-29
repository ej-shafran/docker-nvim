---@class docker.cli.volume
local volume = {}

volume.create = require('docker.cli.volume.create')
volume.inspect = require('docker.cli.volume.inspect')
volume.ls = require('docker.cli.volume.ls')
volume.prune = require('docker.cli.volume.prune')
volume.rm = require('docker.cli.volume.rm')

return volume
