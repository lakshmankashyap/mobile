 # Device.coffee
 #
 # @description :: TODO: You might write a short summary of how this model works and what it represents here.
 # @docs        :: http://sailsjs.org/#!documentation/models
			
module.exports =
	
	autoWatch:			false
	
	autoSubscribe:		false
	
	autoSubscribeDeep:	false
	
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