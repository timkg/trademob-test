mysql = require 'mysql'
config = require('../config')

connection = mysql.createConnection(config.MYSQL_URL)
connection.connect()

exports.mysql = connection