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

*	Push
```
	post api/push - send notification to users with optional data
		users:	array of user email addresses
		data:	json data (e.g. {"url": "https://mob.myvnc.com/im", "msg": "2 messages from 通知你"})
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
	3. apikey - Google GCM API key

a [Sails](http://sailsjs.org) application
