mysql = require('./mysql').mysql
redis = require('./redis').redis

class Campaign

  # callback is called with err and result
  getCouponValue: (campaign_id, callback) ->
    self = this
    self._getCouponValueFromRedis campaign_id, (result) ->
      if result
        callback null, result
        return result
      self._getCouponValueFromMySQL campaign_id, (err, result) ->
        if result
          self._saveCouponValueToRedis(campaign_id, result)
          callback null, result
        else
          callback new Error '2 no coupon_value found for campaign_id ' + campaign_id, null

  _getCouponValueFromRedis: (campaign_id, callback) ->
    redis.get campaign_id, (err, result) ->
      if err then console.log err
      callback result

  _getCouponValueFromMySQL: (campaign_id, callback) ->
    mysql.query "SELECT coupon_value FROM campaigns WHERE campaign_id=#{campaign_id}", (err, result) ->
      if err
        callback err, null
        return false
      if Array.isArray(result) && result.length > 0 && result[0].coupon_value
        callback null, result[0].coupon_value
      else
        callback new Error '1 no coupon_value found for campaign_id ' + campaign_id, null
        return false

  _saveCouponValueToRedis: (campaign_id, coupon_value) ->
    redis.set campaign_id, coupon_value
    coupon_value

exports.Campaign = Campaign