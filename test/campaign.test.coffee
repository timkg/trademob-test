Campaign = require('../services/campaign').Campaign
mysql = require('../services/mysql').mysql
redis = require('../services/redis').redis
expect = require 'expect.js'

CAMPAIGN_ID = 123
COUPON_VALUE = 234

describe 'Campaign service', ->

  before (done) ->
    mysql.connect()
    mysql.query(
      "INSERT INTO campaigns (campaign_id, coupon_value) VALUES (#{CAMPAIGN_ID}, #{COUPON_VALUE})",
      (err, result) ->
        if err then throw err
        done()
        true
      )

  it 'should be defined', ->
    expect(Campaign).to.be.ok()

  it 'should be able to instantiate the service', ->
    campaignService = new Campaign
    expect(campaignService).to.be.ok()

  it 'should query the mysql server for coupon values', (done) ->
    campaignService = new Campaign
    campaignService.getCouponValueFromMySQL CAMPAIGN_ID, (result) ->
      expect(result).to.equal(COUPON_VALUE)
      done()
      true

  it 'should save new coupon values in redis', (done) ->
    campaignService = new Campaign
    campaignService.saveCouponValueToRedis(CAMPAIGN_ID, COUPON_VALUE)
    redis.get CAMPAIGN_ID, (err, value) ->
      expect(parseInt value, 10).to.equal(COUPON_VALUE)
      done()

  after (done) ->
    mysql.query(
      "DELETE FROM campaigns WHERE campaign_id=#{CAMPAIGN_ID}",
      (err, result) ->
        if err then throw err
        done()
        true
      )
