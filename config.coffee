fs = require 'fs'

readTokenFromFile = (tokenName) ->
  data = fs.readFileSync './.env', 'utf8'
  lines = data.split('\n')
  for line in lines
    parts = line.split('=')
    if parts[0] == tokenName
      tokenValue = parts[1]
  tokenValue

exports.REDIS_URL = process.env.REDISTOGO_URL || readTokenFromFile('REDISTOGO_URL')
exports.MYSQL_URL = process.env.MYSQL_URL || readTokenFromFile('DATABASE_URL')
