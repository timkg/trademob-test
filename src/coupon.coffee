uuid = require('node-uuid')
randomString = require('randomstring')
Campaign = require('../services/campaign').Campaign
campaignService = new Campaign

class Coupon

  constructor: (@user_ip, @campaign_id) ->
    throw new ReferenceError('Coupon constructor requires user_ip') unless @user_ip
    throw new ReferenceError('Coupon constructor requires campaign_id') unless @campaign_id
    @uuid = uuid.v1()
    @promo_code = randomString.generate 16

  init: (callback) ->
    self = this
    campaignService.getCouponValue @campaign_id, (coupon_value) ->
      self.coupon_value = parseInt coupon_value, 10
      callback self

  getJSON: ->
    JSON.stringify this

exports.Coupon = Coupon