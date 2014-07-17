Backbone = require 'backbone'
require 'backbone-forms'
require 'backbone-forms/distribution/backbone-forms'
require '../public/js/backbone.bootstrap-modal'
require 'backbone-forms/distribution/editors/list'
require '../public/templates/bootstrap'

# list editor with default value
class DList extends Backbone.Form.editors.List
	events:
		'click [data-action="add"]': 'newDefault'
		 
	constructor: (opts) ->
		super(opts)
		@data = opts.schema.data
	
	newDefault: (event) ->
		event.preventDefault()
		@addItem(@data().toJSON(), true)
		
Backbone.Form.editors.DList = DList

# select editor with object value
class OSelect extends Backbone.Form.editors.Select
	getValue: (value) ->
		id = super()
		@schema.options.findWhere _id: id
		
Backbone.Form.editors.OSelect = OSelect

class MSelect extends Backbone.Form.editors.Select
	constructor: (opts) ->
		opts.attributes ?= {}
		opts.attributes = _.extend opts.attributes, {multiple : 'multiple'}
		super(opts)
		
	render: ->
		super()
		cb = =>
			@$el.multiselect(includeSelectAllOption: true)
			data = @schema.options.map (model) ->
				{label: model.label, value: model.val} 
			@$el.multiselect 'dataprovider', data
		setTimeout cb, 100
		return @
		
	getValue: ->
		@$el.val()
	
	remove: ->
		@$el.multiselect 'destroy'
		super()

Backbone.Form.editors.MSelect = MSelect