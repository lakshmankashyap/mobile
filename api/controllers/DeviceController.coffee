 # DeviceController
 #
 # @description :: Server-side logic for managing devices
 # @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
actionUtil = require 'sails/lib/hooks/blueprints/actionUtil'

module.exports = 
	create: (req, res) ->
		Model = actionUtil.parseModel(req)
		data = actionUtil.parseValues(req)
		data.createdBy = data.createdBy.id
		
		Model.updateOrCreate(_.pick(data, 'model', 'version', 'createdBy'), data)
			.then (newInstance) ->
				if req._sails.hooks.pubsub and req.isSocket
					if Model.autoSubscribe
						Model.subscribe(req, newInstance)
						Model.introduce(newInstance)
					Model.publishCreate(newInstance, !req.options.mirror && req)
				res.created(newInstance)
			.catch res.negotiate