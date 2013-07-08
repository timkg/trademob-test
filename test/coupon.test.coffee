Coupon = require('../src/coupon').Coupon
expect = require 'expect.js'
redis = require('../services/redis').redis
mysql = require('../services/mysql').mysql

REDIS_CAMPAIGN_ID = 987
REDIS_COUPON_VALUE = 876

MYSQL_CAMPAIGN_ID = 123
MYSQL_COUPON_VALUE = 234

USER_IP = '127.0.0.1'

describe 'Coupon', ->

  before (done) ->
    redis.set REDIS_CAMPAIGN_ID, REDIS_COUPON_VALUE
    mysql.query(
      "INSERT INTO campaigns (campaign_id, coupon_value) VALUES (#{MYSQL_CAMPAIGN_ID}, #{MYSQL_COUPON_VALUE})",
    (err, result) ->
      if err then console.log err
      done()
    )

  it 'should be defined', ->
    expect(Coupon).to.be.ok()

  it 'should throw a ReferenceError when initialized without user_ip', ->
    expect( -> coupon = new Coupon).to.throwException (e) ->
      expect(e).to.be.a ReferenceError

  it 'should throw a ReferenceError when initialized without campaign_id', ->
    expect( -> coupon = new Coupon USER_IP).to.throwException (e) ->
      expect(e).to.be.a ReferenceError

  it 'should be possible to create instances', ->
    coupon = new Coupon(USER_IP, REDIS_CAMPAIGN_ID)
    expect(coupon).to.be.ok()

  it 'should create a 16 char random string for the promo code', ->
    coupon = new Coupon(USER_IP, REDIS_CAMPAIGN_ID)
    expect(coupon.promo_code).to.be.ok()
    expect(coupon.promo_code.length).to.equal(16)

  it 'should create a v1 UUID', ->
    coupon = new Coupon(USER_IP, REDIS_CAMPAIGN_ID)
    expect(coupon.uuid).to.be.ok()

  it 'should expose an init method', ->
    coupon = new Coupon(USER_IP, REDIS_CAMPAIGN_ID)
    expect(coupon.init).to.be.a(Function)

  it 'should obtain the coupon_value when init() is called', (done) ->
    coupon = new Coupon(USER_IP, REDIS_CAMPAIGN_ID)
    self = coupon
    coupon.init ->
      expect(self.coupon_value).to.equal(REDIS_COUPON_VALUE)
      done()

  it 'should print a JSON representation of the coupon', (done) ->
    coupon = new Coupon(USER_IP, REDIS_CAMPAIGN_ID)
    self = coupon
    coupon.init ->
      json = self.getJSON()
      expect(json).to.be.ok()
      obj = JSON.parse json
      expect(self).to.eql(obj)
      done()

  after (done) ->
    mysql.query "DELETE FROM campaigns WHERE campaign_id=#{MYSQL_CAMPAIGN_ID}", (err, result) ->
      if err then console.log err
      redis.del REDIS_CAMPAIGN_ID
      redis.del MYSQL_CAMPAIGN_ID
      done()