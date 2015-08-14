path = '/mobile'

module.exports =
	path:			path
	port:			3001
	promise:
		timeout:	10000 # ms
	oauth2:
		verifyURL:			"https://mob.myvnc.com/org/oauth2/verify/"
		scope:				[ "https://mob.myvnc.com/org/users", "https://mob.myvnc.com/mobile/device" ]
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
			senderid:	'ninth-airship-624'
			apikey:		'AIzaSyBmE7ixsvhiCEtGs9NeD3AC-CVqrEd3MnE'