config = require('../config')
redis = require 'redis-url'

connection = redis.connect(config.REDIS_URL)

exports.redis = connection