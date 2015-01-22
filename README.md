mobile
======

Web Application to register mobile device with its GCM registration ID, model, and version

Web Server URL 
--------------
*	User
```
	get api/user - list all registered users of mobile Web App 
```

*   Device

```
    get api/device - return devices list for the input oauth2 token in json
    post api/device - create device with registration id, model, version for the authenticated user
    	regid:		registration id
    	model:		model of the mobile device
    	version:	OS version of the mobile device
    del	api/device/:id - delete the device with the input id 
```

*	GCM
```
	post api/gcm - send notification to users with optional data
		users:	array of username
		data:	json data (e.g. {"url": "https://mob.myvnc.com/im", "msg": "2 messages from 通知你"})
```

Backbone based client to interface with the above Web Server API
----------------------------------------------------------------
*	User
```
	#user/list - list all users of mobile Web App
```

*	Device
```
	#device/list - list all devices for the authenticated user
	#device/create/:regid/:model/:version - register mobile device with the input registration id, model, version for the authenticated user
	#device/delete/:id - delete the device with specified id
```

*	GCM
```
	#gcm - send data to specified users
```

Configuration
=============

*   git clone https://github.com/twhtanghk/mobile.git
*   cd mobile
*   "bower install" to install bower package
*   "npm install" to install npm package
*	"npm run-script prd" to generate client script
*	create mongo database
*	create api key for authorization code and implicit grant in authentication server
*	update environment variable PORT in start.sh
    
```
    export PORT=8005
```

*   update environment variable proj, authServer, clientID for oauth2 Implicit Grant in client/env.cofffee

```
    proj = 'mobile'
	authServer = 'mob.myvnc.com'
	env =
		clientID:		"mobile"
```

*	update the following environment variables in env.coffee
	1. serverUrl - the web url to deploy the web application (e.g. https://mob.myvnc.com/mobile)
	2. dbUrl - mongo database url
	3. clientID - client ID for oauth2 authorization code
	4. clientSecret - client secret for oauth2 authorization code
	5. apikey - Google GCM API key

```
	serverUrl =	"http://localhost:3000/#{envClient.proj}"
	env =
		dbUrl:			"mongodb://mobilerw:password@localhost/mobile"
		clientID:		"mobileAuth"
		clientSecret:	'password'	
		gcm:
			apikey:		'your api key'
```