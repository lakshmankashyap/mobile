model = require '../../model.coffee'
controller = require '../controller/device.coffee'
vent = require '../../vent.coffee'
_ = require 'underscore'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'

class Router extends Backbone.Router
	routes:
		'device/list':			'list'
		'device/delete/:id':	'delete'
		
	constructor: (opts = {}) ->
		@collection = new model.Devices()
		@listView = new controller.DeviceSearchView {el: 'body', collection: @collection}
		super(opts)
			
	list: ->
		@listView.render()
		@listView.collection.getFirstPage(reset: true)
		
module.exports =
	Router:		Router