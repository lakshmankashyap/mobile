env = require '../../../env.coffee'
model = require '../../../model.coffee'
_ = require 'underscore'
http = require 'needle'
passport = require 'passport'
bearer = passport.authenticate('bearer', { session: false })
lib = require '../lib.coffee'
ensurePermission = lib.ensurePermission
logger = env.log4js.getLogger('gcm.coffee')
 
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
			ca:			env.ca
		reject = (err) =>
			logger.error err
			@response.status(500).json(error: err)
		fulfill = (devices) =>
			try 
				data =
					registration_ids:	_.map devices, (dev) -> dev.regid
					data:				JSON.parse(@request.body.data)
				http.post env.gcm.url, data, opts, (err, resp) =>
					if err
						reject(err)
					logger.debug resp.body
					@response.json resp.statusCode, resp.body
			catch err
				reject(err)
		regid(@request.body.users).then fulfill, reject