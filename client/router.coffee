Backbone = require 'backbone'
vent = require './vent.coffee'
env = require './env.coffee'

class Router extends Backbone.Router
	routes:
		'':			'index'
		'logout':	'logout'
		
	index: ->
		@navigate 'device/list', trigger: true
			
	logout: ->
		window.app.jso.wipeTokens()
		vent.info 'successfully logout'
		window.location.href = env.path
		
module.exports =
	Router: Router