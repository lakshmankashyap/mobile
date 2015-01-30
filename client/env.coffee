proj = 'mobile'
authServer = 'mob.myvnc.com'

env =
	proj:				proj
	user:
		url:	"https://#{authServer}/org/api/users/"
	path:		"/#{proj}"
	oauth:
		authServer:		authServer
		verifyUrl:		"https://#{authServer}/org/oauth2/verify/"
		provider_id:	"mobile"
		client_id:		"mobileDEV"
		authorization:	"https://#{authServer}/org/oauth2/authorize/"
		scopes:
			request:	[
				"https://#{authServer}/org/users",
				"https://#{authServer}/mobile/device"
			]
	flash:
		timeout:	5000		# ms	
			
module.exports = env