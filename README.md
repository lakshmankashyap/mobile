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
		data:	json data (e.g. {"url": "https://mob.myvnc.com/im", title: "Instant Messaging", "message": "2 messages from 通知你"}) where default title message are "Instant Messaging" and " " if not defined
```

Configuration
=============

* docker run -v ${COMPOSEROOT}/data:/data/db -d mongo
* docker run -d twhtanghk/mobile or docker-compose -f docker-compose.yml up 
