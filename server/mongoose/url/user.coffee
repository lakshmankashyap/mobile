controller = require "../controller/user.coffee"
passport = require 'passport'
bearer = passport.authenticate('bearer', { session: false })
lib = require '../lib.coffee'
ensurePermission = lib.ensurePermission
 
@include = ->

	@get '/api/user', bearer, ensurePermission('user:list'), ->
		controller.User.list(@request, @response)