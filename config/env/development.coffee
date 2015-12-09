agent = require 'https-proxy-agent'

module.exports =
	port:			3001
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
			host:		'localhost'
			port:		27017
			user:		'mobilerw'
			password:	'password'
			database:	'mobile'
	session:
		adapter:	'mongo'
		host: 		'localhost'
		port: 		27017
		db:			'mobile'
		username:	'mobilerw'
		password:	'password'
	log:
		level:		'silly'
	push:
		gcm:
			url:		'https://android.googleapis.com/gcm/send'
			apikey:		'Google GCM API key'
	http:
		opts:
			agent:	new agent('http://proxy1.scig.gov.hk:8080')