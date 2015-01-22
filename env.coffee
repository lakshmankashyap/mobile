envClient = require './client/env.coffee'

env =
	proj:	envClient.proj
	path:		envClient.path
	dbUrl:		"mongodb://mobilerw:pass1234@localhost/mobile"
	pageSize:	10
	log4js: 	require 'log4js'
	gcm:
		url:		'https://android.googleapis.com/gcm/send'
		apikey:		'your api key'
		
env.log4js.configure './log4js.json', {}
	
module.exports = env