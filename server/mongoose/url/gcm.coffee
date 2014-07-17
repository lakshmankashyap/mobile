env = require '../../../env.coffee'
model = require '../../../model.coffee'
_ = require 'underscore'
http = require 'needle'
passport = require 'passport'
bearer = passport.authenticate('bearer', { session: false })
lib = require '../lib.coffee'
ensurePermission = lib.ensurePermission
 
regid = (users) ->
	opts =
		path: 'createdBy'
		match: 
			'username':
				$in: users
	model.Device.find().populate(opts).exec()
	
@include = ->

	@post '/api/gcm', bearer, ensurePermission('gcm:create'), ->
		headers =
			'Authorization': 	"key=#{env.gcm.apikey}"
			'Content-Type': 	'application/json' 
		opts =
			headers:	headers
			json:		true
		regid(@request.body.users).then (users) =>
			data =
				registration_ids:	_.map users, (user) -> user.regid
				data:				JSON.parse(@request.body.data)
			http.post env.gcm.url, data, opts, (err, resp) =>
				@response.json resp.statusCode, resp.body