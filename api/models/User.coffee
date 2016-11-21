_ = require 'lodash'
Promise = require 'bluebird'

module.exports =

  autoWatch: false
	
  autosubscribe: false
	
  tableName: 'user'
	
  schema: true
	
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
    notify: (data) ->
      sails.log.info @email
      if @devices?.length
        Promise
          .all _.map @devices, (dev) ->
            dev.notify data
      else
        sails.config.notify.smtp @email, data 
