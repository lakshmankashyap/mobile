actionUtil = require 'sails/lib/hooks/blueprints/actionUtil'

# add criteria for room jid and current login user  
module.exports = (req, res, next) ->
	req.options.where = req.options.where || {}
	_.extend req.options.where, createdBy: req.user.id		
	next()