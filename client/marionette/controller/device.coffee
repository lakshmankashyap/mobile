_ = require 'underscore'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
lib = require '../lib.coffee'
ModelView = lib.ModelView
model = require '../../model.coffee'
Device = model.Device
vent = require '../../vent.coffee'
html = lib.html

class Action extends Marionette.ItemView
	template: (data) ->
		"<a class='btn btn-default btn-block delete'>Delete</a>"
		
	events:
		'click .delete':	'delete'
		
	'delete': ->
		vent.trigger 'device:delete hide:cmd'
				
class DeviceView extends Marionette.ItemView
	tagName:	'div'
	
	className:	'device'
	
	template: (data) =>
		@$el.toggleClass 'selected', data.selected
		tmpl = """
			<span class='model'><%= obj.model %></span>
			<span class='version'><%= obj.version %></span>
			<span class='dateCreated'><%= obj.dateCreated %></span>
		"""
		_.template(tmpl)(data)

	events:
		tap:		'select'
		dbltap:		'menu'
		swiperight:	'del'
		
	modelEvents:
		'change':	'render'
		
	constructor: (opts = {}) ->
		super(opts)
		vent.on 'device:delete', @delSelected
				
	destroy: ->
		super()
		vent.off 'device:delete', @delSelected
		
	select: (event) ->
		@model.set 'selected', not @model.get('selected')
		
	menu: (event) ->
		vent.trigger 'show:cmd', title: 'Device', body: new Action()
		
	del: ->
		@model.destroy(wait: true)
	
	delSelected: =>
		if @model.get('selected')
			@model.destroy wait: true

class DeviceSearchView extends Marionette.CompositeView
	childView:	DeviceView
	
	childViewContainer: ".list"
	
	template: (data) =>
		tmpl = """
			<div class='list'>
			</div>
			<ul class="device-pager pager">
				<li class="previous <%=obj.hasPrevious() ? '' : 'disabled'%>">
					<a href="#">&laquo; prev</a>
				</li>
				<li class="next <%=obj.hasNext() ? '' : 'disabled'%>">
					<a href="#">next &raquo;</a>
				</li>
			</ul>
		"""
		_.template(tmpl)(@collection)
		
	events:
		'click .device-pager li.previous':	'prev'
		'click .device-pager li.next':		'next'

	constructor: (opts = {}) ->
		super(opts)
		vent.on 'search', @search
		
	destroy: ->
		super()
		vent.off 'search', @search
		
	search: (val) =>
		@collection.search val
			
	prev: (event) ->
		if $(event.currentTarget).hasClass('disabled')
			return false
		@collection.getPreviousPage()
		return false
		
	next: (event) ->
		if $(event.currentTarget).hasClass('disabled')
			return false
		@collection.getNextPage()
		return false

module.exports =	
	DeviceView:			DeviceView
	DeviceSearchView:	DeviceSearchView