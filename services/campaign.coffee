mysql = require('./mysql').mysql
redis = require('./redis').redis

class Campaign

  getCouponValue: (campaign_id) ->
    return false

  getCouponValueFromRedis: (campaign_id) ->
    return false

  getCouponValueFromMySQL: (campaign_id, callback) ->
    mysql.query(
      "SELECT coupon_value FROM campaigns WHERE campaign_id=#{campaign_id}",
      (err, result) ->
        if err then throw err
        callback(result[0].coupon_value)
      )

  saveCouponValueToRedis: (campaign_id, coupon_value) ->
    redis.set campaign_id, coupon_value
    coupon_value

exports.Campaign = Campaign