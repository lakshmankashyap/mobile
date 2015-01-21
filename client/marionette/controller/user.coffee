_ = require 'underscore'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
lib = require '../lib.coffee'
ModelView = lib.ModelView
model = require '../../model.coffee'
require 'bootstrap-multiselect'
User = model.User
vent = require '../../vent.coffee'
html = lib.html

class UserView extends Marionette.ItemView
	className:	'user'
	
	template: (data) =>
		"""
			<span class='name'>
				#{data.username}
			</span>
			<span class='email'>
				#{data.email}
			</span>
		"""
		
class UserSearchView extends Marionette.CompositeView
	childView:	UserView
	
	childViewContainer: ".list"
	
	template: (data) =>
		tmpl = """
			<div class='list'>
			</div>
			<ul class="user-pager pager">
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
		'click .user-pager li.previous':	'prev'
		'click .user-pager li.next':		'next'
		
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
	UserView: 		UserView
	UserSearchView: UserSearchView