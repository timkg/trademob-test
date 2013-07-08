fs = require 'fs'

readTokenFromFile = (tokenName) ->
  data = fs.readFileSync './.env', 'utf8'
  lines = data.split('\n')
  for line in lines
    parts = line.split('=')
    if parts[0] == tokenName
      tokenValue = parts[1]
      return tokenValue
    else
      return false

exports.MYSQL_URL = process.env.MYSQL_URL || readTokenFromFile('DATABASE_URL')