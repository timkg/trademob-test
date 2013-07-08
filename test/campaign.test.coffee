Campaign = require('../services/campaign').Campaign
mysql = require('../services/mysql').mysql
redis = require('../services/redis').redis
expect = require 'expect.js'

MYSQL_CAMPAIGN_ID = 123
MYSQL_COUPON_VALUE = 234

REDIS_CAMAIGN_ID = 987
REDIS_COUPON_VALUE = 876

describe 'Campaign service', ->

  campaignService = new Campaign

  before (done) ->
    mysql.connect()
    mysql.query(
      "INSERT INTO campaigns (campaign_id, coupon_value) VALUES (#{MYSQL_CAMPAIGN_ID}, #{MYSQL_COUPON_VALUE})",
      (err, result) ->
        if err then throw err
        done()
      )
    redis.set REDIS_CAMAIGN_ID, REDIS_COUPON_VALUE

  it 'should be defined', ->
    expect(Campaign).to.be.ok()

  it 'should be able to instantiate the service', ->
    expect(campaignService).to.be.ok()

  it 'should query the mysql server for coupon values', (done) ->
    campaignService._getCouponValueFromMySQL MYSQL_CAMPAIGN_ID, (result) ->
      expect(result).to.equal(MYSQL_COUPON_VALUE)
      done()

  it 'should query the redis server for coupon values', (done) ->
    campaignService._getCouponValueFromRedis REDIS_CAMAIGN_ID, (value) ->
      expect(parseInt value, 10).to.equal(REDIS_COUPON_VALUE)
      done()

  it 'should save new coupon values in redis', (done) ->
    campaignService._saveCouponValueToRedis(MYSQL_CAMPAIGN_ID, MYSQL_COUPON_VALUE)
    redis.get MYSQL_CAMPAIGN_ID, (err, value) ->
      expect(parseInt value, 10).to.equal(MYSQL_COUPON_VALUE)
      done()

  it 'should save coupon values obtained from mysql into redis', (done) ->
    campaignService.getCouponValue MYSQL_CAMPAIGN_ID, (result) ->
      campaignService._getCouponValueFromRedis MYSQL_CAMPAIGN_ID, (valueFromRedis) ->
        expect(parseInt(valueFromRedis, 10)).to.equal(MYSQL_COUPON_VALUE)
        done()

  after (done) ->
    mysql.query(
      "DELETE FROM campaigns WHERE campaign_id=#{MYSQL_CAMPAIGN_ID}",
      (err, result) ->
        if err then throw err
        done()
        true
      )
    redis.del REDIS_CAMAIGN_ID
    redis.del MYSQL_CAMPAIGN_ID
