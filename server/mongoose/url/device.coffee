env = require '../../../env.coffee'
path = require 'path'
controller = require "../controller/device.coffee"
passport = require 'passport'
bearer = passport.authenticate('bearer', { session: false })
lib = require '../lib.coffee'
ensurePermission = lib.ensurePermission
ensureLoggedIn = require('connect-ensure-login').ensureLoggedIn
 
@include = ->

	# register the device 
	@get '/device/:regid/:model/:version', ensureLoggedIn(path.join env.path, env.oauth2.authURL), ensurePermission('device:create'), ->
		controller.Device.register(@request, @response)
	
	@get '/api/device', bearer, ensurePermission('device:list'), ->
		controller.Device.list(@request, @response)
		
	@del '/api/device/:id', bearer, ensurePermission('device:delete'), ->
		controller.Device.delete(@request, @response)