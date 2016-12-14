req = require 'supertest'    

describe 'PushController', ->
  describe 'create', ->
    @timeout process.env.TIMEOUT || 4000000

    it "push msg to #{process.env.USEREMAIL}", ->
      sails.services.oauth2
        .token()
        .then (token) ->
          req sails.hooks.http.app
            .post '/api/push'
            .set 'Authorization', "Bearer #{token}"
            .send
              users: [process.env.USEREMAIL]
              data: 
                title: 'Instant Messaging'
                message: 'test message'
            .expect 200

    it "push msg to all iPhone", ->
      sails.services.oauth2
        .token()
        .then (token) ->
          sails.models.device
            .find model: like: 'iPhone%'
            .populateAll()
        .map (device) ->
          device
            .notify
              title: 'Instant Messaging'
              message: 'test message'
            .catch (err) ->
              sails.log.error "failed to send msg to #{device.createdBy.username}:#{device.model}:#{device.version}"
              throw err
