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
		reject = (err) ->
			sails.log.error err
			res.serverError err
		sails.models.user
			.find()
			.where(email: values.users)
			.populateAll()
			.then (to) ->
				fulfill = (body) ->
					sails.log.info "#{_.pluck(to, 'email')}: #{JSON.stringify body}"
					res.ok body
				sails.services.rest
					.gcmPush to, values.data
					.then fulfill
			.catch reject