 # User.coffee
 #
 # @description :: TODO: You might write a short summary of how this model works and what it represents here.
 # @docs        :: http://sailsjs.org/#!documentation/models

module.exports =
	
	autoWatch:			false
	
	autosubscribe:		false
	
	tableName:			'user'
	
	schema:				true
	
	attributes:
		url:
			type: 		'string'
			required: 	true
			unique: 	true
		username:
			type: 		'string'
			required: 	true
		email:
			type:		'string' 
			required:	true
		devices:
			collection:	'device'
			via:		'createdBy'