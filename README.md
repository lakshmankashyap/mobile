mobile
======

Web Application to 

* register ios/android mobile device with its registration ID, model, and version
* send APN/GCM/SMTP notification to user registered mobile devices or email address

Web Server URL 
--------------
*	User
```
	get api/user - list all registered users of mobile Web App 
```

*   Device

```
    get api/device - return devices list for the input oauth2 token
    post api/device - create device with registration id, model, version for the authenticated user
    	regid:		registration id
    	model:		model of the mobile device
    	version:	OS version of the mobile device
    del	api/device/:id - delete the device with the input id 
```

*	Push
```
	post api/push - send APN/GCM/SMTP notification to users with optional data
		users:	array of user email addresses
		data:	json data (e.g. {"url": "https://mob.myvnc.com/im", title: "Instant Messaging", "message": "2 messages from 通知你"}) where default title message are "Instant Messaging" and " " if not defined
```

Configuration
=============

* create certificate and private key file "apn.p12"
* update environment variables defined in .env
* docker run -v ${COMPOSEROOT}/data:/data/db -d mongo
* docker-compose -f docker-compose.yml up 
