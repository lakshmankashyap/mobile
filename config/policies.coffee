module.exports = 
	policies:
		UserController:
			'*':		false
			find:		['isAuth']
			findOne:	['isAuth', 'user/me']
		DeviceController:
			'*':		false
			find:		['isAuth', 'device/filterByOwner']
			create:		['isAuth', 'setOwner']
			update:		['isAuth', 'isOwner', 'omitId']
			destroy:	['isAuth', 'isOwner']
		PushController:
			'*':		false
			create:		['isAuth']