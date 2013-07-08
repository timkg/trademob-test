express = require 'express'
app = express()

exports.init = ->
  app.get '/', (req, res) ->
    res.end('yo')

exports.start = (port) ->
  exports.init()

  app.listen port, ->
    console.log 'server running on port ' + port