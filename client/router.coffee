Backbone = require 'backbone'

class Router extends Backbone.Router
	routes:
		'':			'index'
		
	index: ->
		@navigate 'device/list', trigger: true
			
module.exports =
	Router: Router