Campaign = require('../services/campaign').Campaign
mysql = require('../services/mysql').mysql
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
      console.log err
      console.log result
      done()
      true
    )

  it 'should be defined', ->
    expect(Campaign).to.be.ok()

  it 'should be able to instantiate the service', ->
    campaignService = new Campaign
    expect(campaignService).to.be.ok()

  it 'should expose a getCouponValue method', ->
    campaignService = new Campaign
    expect(campaignService.getCouponValue).to.be.ok()

  it 'should return the coupon value for a given campaign_id', ->

  it 'should query the mysql server for coupon values', ->

  it 'should save new coupon values in redis', ->

  after (done) ->
    mysql.query(
      "DELETE FROM campaigns WHERE campaign_id=#{CAMPAIGN_ID}",
      (err, result) ->
        if err then throw err
        console.log err
        console.log result
        done()
        true
      )
