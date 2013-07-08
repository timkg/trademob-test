Coupon = require('../src/coupon').Coupon
expect = require 'expect.js'
redis = require('../services/redis').redis

REDIS_CAMPAIGN_ID = 987
REDIS_COUPON_VALUE = 876

describe 'Coupon', ->

  before ->
    redis.set REDIS_CAMPAIGN_ID, REDIS_COUPON_VALUE

  it 'should be defined', ->
    expect(Coupon).to.be.ok()

  it 'should throw a ReferenceError when initialized without user_ip', ->
    expect( -> coupon = new Coupon).to.throwException (e) ->
      expect(e).to.be.a ReferenceError

  it 'should throw a ReferenceError when initialized without campaign_id', ->
    expect( -> coupon = new Coupon 1).to.throwException (e) ->
      expect(e).to.be.a ReferenceError

  it 'should be possible to create instances', ->
    coupon = new Coupon(1, 1)
    expect(coupon).to.be.ok()

  it 'should create a 16 char random string for the promo code', ->
    coupon = new Coupon(1, 1)
    expect(coupon.promoCode).to.be.ok()
    expect(coupon.promoCode.length).to.equal(16)

  it 'should create a v1 UUID', ->
    coupon = new Coupon(1, 1)
    expect(coupon.uuid).to.be.ok()

  it 'should expose an init method', ->
    coupon = new Coupon(1, 1)
    expect(coupon.init).to.be.a(Function)

  it 'should obtain the coupon_value when init() is called', (done) ->
    coupon = new Coupon(1, REDIS_CAMPAIGN_ID)
    self = coupon
    coupon.init ->
      expect(self.coupon_value).to.equal(REDIS_COUPON_VALUE)
      done()

  it 'should print a JSON representation of the coupon', (done) ->
    coupon = new Coupon(1, REDIS_CAMPAIGN_ID)
    self = coupon
    coupon.init ->
      json = self.getJSON()
      expect(json).to.be.ok()
      obj = JSON.parse json
      expect(self).to.eql(obj)
      done()

  after ->
    redis.del REDIS_CAMPAIGN_ID