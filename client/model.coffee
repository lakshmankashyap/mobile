env = require './env.coffee'
_ = require 'underscore'
Backbone = require 'backbone'
PageableCollection = require 'backbone-pageable'
Promise = require 'promise'
path = require 'path'

class Model extends Backbone.Model
	idAttribute:	'_id'
	
	# input fields
	fields: ->
		_.keys @schema
		
	# fields to be displayed
	showFields: ->
		_.keys @schema
		
	constructor: (attrs = {}, opts = {}) ->
		attrs = _.defaults attrs, selected: false
		super(attrs, opts)
		
class PageableCollection extends Backbone.PageableCollection
	pattern:	''
	
	state:
		pageSize:	10
		
	queryParams:
		sortKey:	'order_by'
		
	parseState: (resp, queryParams, state, options) ->
		ret = _.clone(state)
		ret.totalRecords = resp.count
		ret.lastPage = Math.ceil(resp.count / ret.pageSize)
		ret.totalPages = ret.lastPage
		return ret
		
	parseRecords: (res) ->
		return res.results
		
	search: (val) ->
		@getFirstPage reset: true, data: search: val
		
class User extends Model
	urlRoot:	"#{env.path}/api/user"
	
	schema:
		url:			{ type: 'Text', title: 'URL'}
		username:		{ type: 'Text', title: 'Username' }
		email:			{ type: 'Text', title: 'Email' }
		tags:
			type: 		'List'
			itemType: 	'NestedModel'
			model: 		String
			title: 		'Tags'
			
	@fields:	
		show:	[ 'username' ]
	
	showFields: ->
		_.keys _.pick(@schema, 'username')
		
	toString: ->
		@get 'username'
		
	homeDir: ->
		"#{@get('username')}/" 
		
class Users extends PageableCollection
	url:		"#{env.path}/api/user"
	
	comparator:	'username'
	
	model:	User
	
	schema:
		models:	{type: 'List', itemType: 'NestedModel', model: User }
			
class AllUsers extends Backbone.Collection
	url:		"#{env.path}/api/user/all"
	
	comparator:	'username'
	
	model:	User
	
	schema:
		models:	{type: 'List', itemType: 'NestedModel', model: User }
	
class OAuth2Users extends Users
	url:		env.user.url
		
	@me: ->
		user = new User()
		p = user.fetch url: env.user.url + 'me/'
		p.then ->
			return user

class Device extends Model
	idAttribute:	'_id'
		
	parse: (res, opts) ->
		if res.dateCreated
			res.dateCreated = new Date(Date.parse(res.dateCreated))
		return res
	
	toString: ->
		@get('regid')
							
class Devices extends PageableCollection
	url:	"#{env.path}/api/device"
	
	comparator:	'dateCreated'
	
	model:		Device
	
class GCMMessage extends Model
	url: ->
		"#{env.path}/api/gcm"
		  
module.exports =
	User:			User
	Users:			Users
	AllUsers:		AllUsers
	OAuth2Users:	OAuth2Users
	Device:			Device
	Devices:		Devices
	GCMMessage:		GCMMessage