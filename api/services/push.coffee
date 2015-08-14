Promise = require 'promise'
http = require 'needle'

module.exports =
	send: (users, data) ->
		new Promise (fulfill, reject) ->
			opts =
				headers:
					Authorization: 	"key=#{sails.config.push.gcm.apikey}"
					'Content-Type': 'application/json'
				json:		true
			devices = _.reduce users, (devices = [], user) ->
				_.union devices, user.devices
			data =
				registration_ids:	_.map devices, (dev) -> dev.regid
				data:				JSON.parse(@request.body.data)
			http.post sails.config.push.gcm.url, data, opts, (err, res) =>
				if err
					return reject(err)
				fulfill(res)