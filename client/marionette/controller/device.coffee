_ = require 'underscore'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
lib = require '../lib.coffee'
View = lib.View
ModelView = lib.ModelView
model = require '../../model.coffee'
Device = model.Device
vent = require '../../vent.coffee'
bootbox = require 'bootbox'

class DeviceView extends View
	tagName:	'tr'
	
	template: (data) =>
		tmpl = """
			<td><%= obj.model %></td>
			<td><%= obj.version %></td>
			<td><%= obj.dateCreated %></td>
			<td>
				<button id="delete" type="button" class="btn btn-default btn-xs">
					<span class="glyphicon glyphicon-trash"></span> Delete
				</button>
			</td>
		"""
		_.template(tmpl)(data)

	events:
		'click button#delete':	'delete'
		
	'delete': ->
		bootbox.confirm "Are you sure?", (result) =>
			if result
				@model.destroy(wait: true)
			bootbox.hideAll()
	
class DeviceListView extends Marionette.CompositeView
	childView:	DeviceView
	
	childViewContainer: "tbody"
	
	template: (data) =>
		"""
			<div>
				<div class="left-inner-addon form-inline search">
					<i class="glyphicon glyphicon-search"></i>
					<input class="form-control" id="search" type="text">
				</div>
			</div>
			<table class='data-list'>
				<thead>
					<th>Model</th>
					<th>Version</th>
					<th>Date Registered</th>
				</thead>
				<tbody></tbody>
			</table>
		"""
		
class DeviceSearchView extends Marionette.CompositeView
	childView:	DeviceView
	
	childViewContainer: "tbody"
	
	template: (data) =>
		tmpl = """
			<div class="left-inner-addon form-inline search">
				<i class="glyphicon glyphicon-search"></i>
				<input class="form-control device-search" type="text">
			</div>
			<div>
				<table class='data-list'>
					<thead>
						<th>Model</th>
						<th>Version</th>
						<th>Date Registered</th>
					</thead>
					<tbody></tbody>
				</table>
				<ul class="device-pager pager">
					<li class="previous <%=obj.hasPrevious() ? '' : 'disabled'%>">
						<a href="#">&laquo; prev</a>
					</li>
					<li class="next <%=obj.hasNext() ? '' : 'disabled'%>">
						<a href="#">next &raquo;</a>
					</li>
				</ul>
			</div>
		"""
		_.template(tmpl)(@collection)
		
	events:
		'input .device-search':				'search'
		'click .device-list li':			'select'
		'click .device-pager li.previous':	'prev'
		'click .device-pager li.next':		'next'
			
	search: (event) ->
		@collection.search $(event.target).val()
		
	select: (event) ->
		@router.navigate "#device/read/#{$(event.target).attr('id')}", trigger: true
		
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
	DeviceListView: 	DeviceListView
	DeviceSearchView: DeviceSearchView