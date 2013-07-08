mysql = require('./mysql').mysql
redis = require('./redis').redis

class Campaign

  getCouponValue: (campaign_id, callback) ->
    self = this
    redisValue = self._getCouponValueFromRedis campaign_id, (result) ->
      if result then callback result
      mysqlValue = self._getCouponValueFromMySQL campaign_id, (result) ->
        if result
          self._saveCouponValueToRedis(campaign_id, result)
          callback result

  _getCouponValueFromRedis: (campaign_id, callback) ->
    redis.get campaign_id, (err, result) ->
      if err then console.log err
      callback(result)

  _getCouponValueFromMySQL: (campaign_id, callback) ->
    mysql.query(
      "SELECT coupon_value FROM campaigns WHERE campaign_id=#{campaign_id}",
      (err, result) ->
        if err then console.log err
        callback(result[0].coupon_value)
      )

  _saveCouponValueToRedis: (campaign_id, coupon_value) ->
    redis.set campaign_id, coupon_value
    coupon_value

exports.Campaign = Campaign