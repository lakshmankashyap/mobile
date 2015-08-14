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
*   "npm install" to install npm package
*	create mongo database
*	create api key for authorization code and implicit grant in authentication server
*	update environment variable 'port', 'verifyURL', 'apikey', database connection in config/env/prodcution.coffee
    
```
    port: 8000
    ...
    ...
    oauth2:
		verifyURL:			"https://mob.myvnc.com/org/oauth2/verify/"
	...
	...
	push:
		gcm:
			url:		'https://android.googleapis.com/gcm/send'
			senderid:	'Google Sender ID'
			apikey:		'Google GCM API key'
```