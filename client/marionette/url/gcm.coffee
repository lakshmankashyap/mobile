controller = require '../controller/gcm.coffee'
_ = require 'underscore'
Backbone = require 'backbone'

class Router extends Backbone.Router
	routes:
		'gcm':		'gcm'
		
	gcm: ->
		window.app.page.show new controller.GCMView()
		
module.exports =
	Router:		Router