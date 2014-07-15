model = require '../../model.coffee'
controller = require '../controller/user.coffee'
vent = require '../../vent.coffee'
_ = require 'underscore'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'

class Router extends Backbone.Router
	routes:
		'user/list':		'list'
		'user/create':		'create'
		'user/read/:id':	'read'
		'user/update/:id':	'update'
		
	constructor: (opts = {}) ->
		@collection = new model.Users()
		@listView = new controller.UserSelectView {el: 'body', collection: @collection}
		super(opts)
			
	list: ->
		@listView.render()
		@listView.collection.getFirstPage(reset: true)
		
module.exports =
	Router:		Router