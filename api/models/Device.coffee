 # Device.coffee
 #
 # @description :: TODO: You might write a short summary of how this model works and what it represents here.
 # @docs        :: http://sailsjs.org/#!documentation/models
Promise = require 'promise'
		
module.exports =
	
	autoWatch:			false
	
	autosubscribe:		false
	
	tableName:			'device'
	
	schema:				true
	
	attributes:
		regid:			
			type: 		'string'
			required:	true
			unique: 	true
		model:
			type:		'string'
		version:
			type:		'string'
		createdBy:
			model:		'user'
	
	updateOrCreate:	(criteria, data) ->
		new Promise (fulfill, reject) =>
			@findOne criteria
				.then (model) =>
					if model
						if model.regid == data.regid
							fulfill data
						else
							@update criteria, data
								.then (data) ->
									sails.log.info "updated: #{JSON.stringify(data)}"
									fulfill data
					else
						@create data
							.then (data) ->
								sails.log.info "created: #{JSON.stringify(data)}"
								fulfill data
				.catch reject