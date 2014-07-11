env = require '../../../env.coffee'
controller = require "../controller/device.coffee"
passport = require 'passport'
bearer = passport.authenticate('bearer', { session: false })
lib = require '../lib.coffee'
ensurePermission = lib.ensurePermission
ensureLoggedIn = require('connect-ensure-login').ensureLoggedIn
 
@include = ->

	# register the device 
	@get '/device/:regid/:model/:version', ensureLoggedIn(env.oauth2.authURL), ensurePermission('device:create'), ->
		controller.Device.register(@request, @response)
	
	@get '/api/device', bearer, ensurePermission('device:list'), ->
		controller.Device.list(@request, @response)
		
	@post '/api/device', bearer, ensurePermission('device:create'), ->
		controller.Device.create(@request, @response) 
		
	@get '/api/device/:id', bearer, ensurePermission('device:read'), ->
		controller.Device.read(@request, @response)
		
	@put '/api/device/:id', bearer, ensurePermission('device:update'), ->
		controller.Device.update(@request, @response)
		
	@del '/api/device/:id', bearer, ensurePermission('device:delete'), ->
		controller.Device.delete(@request, @response)