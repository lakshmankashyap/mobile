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
		jso_wipe()
		vent.info 'successfully logout'
		window.location.href = env.path
		
module.exports =
	Router: Router