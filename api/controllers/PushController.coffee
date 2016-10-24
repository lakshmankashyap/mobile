_ = require 'lodash'
actionUtil = require 'sails/lib/hooks/blueprints/actionUtil'

module.exports =
	# req.user: current login user
	# users:	array of users url
	# data:		message data to be sent
	create: (req, res) ->
		values = actionUtil.parseValues(req)
		sails.models.user
			.find()
			.where(email: values.users)
			.populateAll()
			.then (to) ->
				Promise.all _.map to, (user) ->
					user.notify values.data
			.then (body) ->
				sails.log.info JSON.stringify body
				res.ok body
			.catch (err) ->
				sails.log.error err
				res.serverError err
