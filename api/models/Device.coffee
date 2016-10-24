_ = require 'lodash'
Promise = require 'bluebird'

apn = require 'apn'

apnProvider = new apn.Provider
  pfx: process.env.APNPFX
  passphrase: process.env.APNPASS
  production: false

gcm = require 'node-gcm'

gcmProvider = Promise.promisifyAll new gcm.Sender process.env.GCMKEY
    
module.exports =
  
  autoWatch: false
  
  autosubscribe: false
  
  tableName: 'device'
  
  schema: true
  
  attributes:
    regid:      
      type: 'string'
      required: true
      unique: true
    model:
      type: 'string'
    version:
      type: 'string'
    createdBy:
      model: 'user'
    type: ->
      if @model.match /iphone/i
        return 'ios'
      else
        return 'android'
    notify: (data) ->
      switch true
        when @type() == 'ios'
          sails.config.notify.apn @regid, data
        when @type() == 'android'
          sails.config.notify.gcm @regid, data
        
  updateOrCreate:  (criteria, data) ->
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
