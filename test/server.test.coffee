expect = require 'expect.js'
request = require 'request'

describe 'server', ->

  it 'accepts get requests on "/"', (done) ->
    request 'http://localhost:5000/', (err, response, body) ->
      expect(response.statusCode).to.equal(200)
      done()