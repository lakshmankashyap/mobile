controller = require "../controller/user.coffee"
passport = require 'passport'
bearer = passport.authenticate('bearer', { session: false })
lib = require '../lib.coffee'
ensurePermission = lib.ensurePermission
 
@include = ->

	@get '/api/user', bearer, ensurePermission('user:list'), ->
		controller.User.list(@request, @response)
		
	@get '/api/user/all', bearer, ensurePermission('user:list'), ->
		controller.User.listAll(@request, @response)