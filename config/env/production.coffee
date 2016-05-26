agent = require 'https-proxy-agent'

module.exports =
	promise:
		timeout:	10000 # ms
	oauth2:
		verifyURL:			"https://mob.myvnc.com/org/oauth2/verify/"
		scope:				[ "https://mob.myvnc.com/org/users", "https://mob.myvnc.com/mobile" ]
	models:
		connection: 'mongo'
		migrate:	'alter'
	connections:
		mongo:
			adapter:	'sails-mongo'
			driver:		'mongodb'
			url:		'mongodb://root@mongo/im'
	log:
		level:		'silly'
	push:
		gcm:
			url:		'https://android.googleapis.com/gcm/send'
			apikey:		'Google GCM API key'
