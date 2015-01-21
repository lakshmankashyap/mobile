Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
require 'bootstrap.growl'
	
vent = new Backbone.Wreqr.EventAggregator()

vent.on 'show:msg', (msg, type = 'info') =>
	$.growl {message: msg, type: type}
	
vent.info = (msg) ->
	$.growl {message: msg}

vent.error = (msg) ->
	$.growl {message: msg, type: 'error'}
			
module.exports = vent