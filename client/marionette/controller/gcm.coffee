_ = require 'underscore'
Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
require '../../form.coffee'
lib = require '../lib.coffee'
View = lib.View
ModelView = lib.ModelView
model = require '../../model.coffee'

class GCMView extends Marionette.ItemView
	constructor: (opts) ->
		super(opts)
		@users = new model.AllUsers()
				
	template: (data) =>
		@form.render().el
		
	render: ->
		@users.fetch().then (res) =>
			data = @users.map (user) ->
				{ val: user.get('username'), label: user.get('username') }
			@form = new Backbone.Form
				schema:
					users:	{ type: 'MSelect', options: data }
					data:	{ type: 'Text' }
				template: 	_.template """
						<form class="form-horizontal">
							 <div data-fieldsets>
							 </div>
							 <button type='submit' class='btn btn-default'>
							 	<span class="glyphicon glyphicon-envelop"></span>
							 	Send
							 </button>
						</form>
					"""
				events:
					submit: (event) =>
						event.preventDefault()
						msg = new model.GCMMessage @form.getValue()
						msg.save()
			super()
			
module.exports =	
	GCMView:	GCMView