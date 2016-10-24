Promise = require 'bluebird'
needle = Promise.promisifyAll require 'needle'

module.exports =
  # get token for Resource Owner Password Credentials Grant
  # url: authorization server url to get token 
  # client:
  #   id: registered client id
  #   secret: client secret
  # user:
  #   id: registered user id
  #   secret: user password
  # scope: [ "https://mob.myvnc.com/org/users", "https://mob.myvnc.com/mobile"]
  token: (opts = {}) ->
    opts = _.defaults opts,
      url: sails.config.oauth2.tokenURL
      client:
        id: process.env.CLIENTID
        secret: process.env.CLIENTSECRET
      user:
        id: process.env.USERID
        secret: process.env.USERSECRET
      scope: sails.config.oauth2.scope
    data =
      grant_type: 'password'
      username: opts.user.id
      password: opts.user.secret 
      scope: opts.scope.join ' '
    needle
      .postAsync opts.url, data,
        'Content-Type': 'application/x-www-form-urlencoded'
        username: opts.client.id
        password: opts.client.secret
      .then (res) ->
        res.body.access_token
