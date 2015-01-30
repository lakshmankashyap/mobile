env = require './env.coffee'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
require './form.coffee'
router = require './router.coffee'
userRouter = require './marionette/url/user.coffee'
deviceRouter = require './marionette/url/device.coffee'
gcmRouter = require './marionette/url/gcm.coffee'
model = require './model.coffee'
vent = require './vent.coffee'
lib = require './marionette/lib.coffee'

class App extends Marionette.Application
	constructor: (opts = {}) ->
		super(opts)
		
		# configure to acquire bearer token for all api call from oauth2 server
		JSO.enablejQuery(Backbone.$)
		@jso = new JSO env.oauth
		@jso.callback()
		
		sync = Backbone.sync
		Backbone.sync = (method, model, opts) ->
			error = opts.error
			opts.error = (resp) ->
				error(resp)
				vent.trigger 'show:msg', resp.responseJSON.error, 'error'
			sync method, model, opts
				
		Backbone.ajax = (settings) =>
			settings = _.defaults settings, oauth: env.oauth
			@jso.ajax(settings)
		
		success = (user) =>
			@user = user
			new router.Router()
			new userRouter.Router()
			new deviceRouter.Router()
			new gcmRouter.Router()
			Backbone.history.start()
			
		error = ->
			alert 'Unauthorized access'
		
		@page = new lib.PageView()
		
		model.OAuth2Users.me().then success, error
		
module.exports =
	App: App