_ = require 'underscore'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
lib = require '../lib.coffee'
View = lib.View
ModelView = lib.ModelView
model = require '../../model.coffee'
require 'bootstrap-multiselect'
User = model.User

class UserView extends View
	tagName:	'li'
	
	template: (data) =>
		@model.toString()
		
	events:
		'click':				'toggleSelect'
		
	toggleSelect: =>
		@$el.toggleClass 'selected' 
		
class UserListView extends Marionette.CompositeView
	childView:	UserView
	
	childViewContainer: "ul.list"
		
	template: =>
		tmpl = """
			<ul class='list'>
			</ul>
		"""
		_.template(tmpl)(@collection)

class UserSearchView extends UserListView
	childView:	UserView
	
	childViewContainer: "ul.list"
	
	template: =>
		tmpl = """
			<div class="left-inner-addon form-inline search">
				<i class="glyphicon glyphicon-search"></i>
				<input class="form-control user-search" type="text">
			</div>
			<ul class='list'>
			</ul>
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
		'input .user-search':				'search'
		'click .user-pager li.previous':	'prev'
		'click .user-pager li.next':		'next'
		
	search: (event) ->
		@collection.search $(event.target).val()
		
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
	UserListView: 	UserListView
	UserSearchView: UserSearchView