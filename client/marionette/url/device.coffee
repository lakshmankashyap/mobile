model = require '../../model.coffee'
Device = model.Device
controller = require '../controller/device.coffee'
vent = require '../../vent.coffee'
_ = require 'underscore'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
lib = require '../lib.coffee'

class Router extends Backbone.Router
	routes:
		'device/list':							'list'
		'device/create/:regid/:model/:version':	'create'
		'device/delete/:id':					'delete'
		
	constructor: (opts = {}) ->
		@collection = new model.Devices()
		super(opts)
			
	create: (regid, model, version) ->
		attrs =
			regid:		regid
			model:		model
			version:	version
		dev = new Device attrs, collection: @collection
		dev.save().then =>
			@navigate 'device/list', trigger: true
		
	list: ->
		window.app.page.show new controller.DeviceSearchView collection: @collection
		@collection.getFirstPage(reset: true)
		
	'delete': (id) ->
		dev = new model.Device id: id
		dev.destroy().then =>
			@navigate 'device/list', trigger: true
		
module.exports =
	Router:		Router