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
		verifyUrl:		"https://#{authServer}/org/oauth2/verify/"
		authUrl:		"https://#{authServer}/org/oauth2/authorize/"
		scope:			[
			"https://#{authServer}/org/users",
			"https://#{authServer}/mobile/device"
		]
	flash:
		timeout:	5000		# ms	
			
module.exports = env