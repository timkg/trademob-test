mysql = require('./mysql')

class Campaign

  getCouponValue: (campaign_id) ->
    return false

  getCouponValueFromRedis: (campaign_id) ->
    return false

  getCouponValueFromMySQL: (campaign_id) ->


  saveCouponValueToRedis: (campaign_id, coupon_value) ->
    return false

exports.Campaign = Campaign