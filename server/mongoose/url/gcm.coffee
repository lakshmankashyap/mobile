env = require '../../../env.coffee'
model = require '../../../model.coffee'
http = require 'needle'
bearer = passport.authenticate('bearer', { session: false })
ensurePermission = lib.ensurePermission
 
regid = (users) ->
	p = model.Device.find({createdBy.username: {$in: users}}).exec()
	p.then (err, result) ->
		if err
			return []
		return result		  
	
@include = ->

	@post '/api/gcm', bearer, ensurePermission('gcm:send'), ->
		headers =
			Authorization: 	env.gcm.apikey
			Content-Type: 	'application/json' 
		opts =
			headers:	headers
		http.post env.gcm.url, opts,
		req.body.users
		req.body.data