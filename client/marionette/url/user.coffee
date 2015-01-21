model = require '../../model.coffee'
controller = require '../controller/user.coffee'
vent = require '../../vent.coffee'
_ = require 'underscore'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
lib = require '../lib.coffee'

class Router extends Backbone.Router
	routes:
		'user/list':		'list'
		
	constructor: (opts = {}) ->
		@collection = new model.Users()
		super(opts)
			
	list: ->
		lib.PageView.getInstance().show new controller.UserSearchView collection: @collection
		@collection.getFirstPage(reset: true)
		
module.exports =
	Router:		Router