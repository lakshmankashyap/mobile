 # PushController
 #
 # @description :: Server-side logic for managing groups
 # @help        :: See http://links.sailsjs.org/docs/controllers
actionUtil = require 'sails/lib/hooks/blueprints/actionUtil'

module.exports =
	# req.user: current login user
	# users:	array of users url
	# data:		message data to be sent
	create: (req, res) ->
		values = actionUtil.parseValues(req)
		fulfill = (body) ->
			sails.log.info body
			res.ok body
		reject = (err) ->
			sails.log.error err
			res.serverError err
		sails.models.user
			.find()
			.where(email: values.users)
			.populateAll()
			.then (to) ->
				sails.services.rest
					.gcmPush to, values.data
					.then fulfill
			.catch reject