proj = 'mobile'
authServer = 'mob.myvnc.com'

env =
	proj:				proj
	user:
		url:	"https://#{authServer}/org/api/users/"
	path:		"/#{proj}"
	oauth2:
		clientID:		"mobileDEV"
		authServer:		authServer
		authUrl:		"https://#{authServer}/org/oauth2/authorize/"
		scope:			[
			"https://#{authServer}/org/users",
			"https://#{authServer}/mobile/device"
		]
	flash:
		timeout:	5000		# ms	
			
module.exports = env