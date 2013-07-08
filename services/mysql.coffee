mysql = require 'mysql'
config = require('../config')

connection = mysql.createConnection(config.MYSQL_URL)

exports.mysql = connection