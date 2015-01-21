model = require '../../model.coffee'
controller = require '../controller/device.coffee'
vent = require '../../vent.coffee'
_ = require 'underscore'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
lib = require '../lib.coffee'

class Router extends Backbone.Router
	routes:
		'device/list':			'list'
		'device/delete/:id':	'delete'
		
	constructor: (opts = {}) ->
		@collection = new model.Devices()
		super(opts)
			
	list: ->
		lib.PageView.getInstance().show new controller.DeviceSearchView collection: @collection
		@collection.getFirstPage(reset: true)
		
module.exports =
	Router:		Router