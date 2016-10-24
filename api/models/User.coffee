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
    ###
    group the user device into android or ios type
    { 
      ios: [ ios1, ios2, ... ]
      android: [ android1, android2, ... ]
    }
    ###
    devGroup: ->
      _.groupBy @devices, (dev) ->
        dev.type()
    notify: (data) ->
      if @devices?.length
        Promise
          .all _.map @devices, (dev) ->
            dev.notify data
      else
        sails.config.notify.smtp @email, data 
