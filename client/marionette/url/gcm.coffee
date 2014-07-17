controller = require '../controller/gcm.coffee'
_ = require 'underscore'
Backbone = require 'backbone'

class Router extends Backbone.Router
	routes:
		'gcm':		'gcm'
		
	constructor: (opts = {}) ->
		@gcmView = new controller.GCMView {el: 'body'}
		super(opts)
			
	gcm: ->
		@gcmView.render()
		
module.exports =
	Router:		Router