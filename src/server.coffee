express = require 'express'
app = express()

Coupon = require('./coupon').Coupon

exports.init = ->
  app.get '/', (req, res) ->
    res.end('yo')

  app.get '/coupon', (req, res) ->
    user_ip = req.query.user_ip
    campaign_id = parseInt req.query.campaign_id, 10

    if typeof campaign_id != 'number' || typeof user_ip != 'string'
      res.statusCode = 400
      res.end 'Coupon creation requires GET request with querystring parameters campaign_id (int) and user_ip (string)'

    coupon = new Coupon user_ip, campaign_id
    coupon.init (coupon) ->
      res.json coupon

exports.start = (port) ->
  exports.init()

  app.listen port, ->
    console.log 'server running on port ' + port