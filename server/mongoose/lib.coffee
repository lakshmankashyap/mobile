field = (name) ->
	if name.charAt(0) == '-'
		return name.substring(1)
	return name
	
order = (name) ->
	if name.charAt(0) == '-'
		return -1
	return 1
	
order_by = (name) ->
	ret = {}
	ret[field(name)] = order(name)
	return ret
		
ensurePermission = (p) ->
	(req, res, next) ->
		user = req.user
		
		if p == 'device:create' or p == 'device:list'
			return next()
			
		model.Device.findById req.params.id, (err, device) ->
			if err or file == null
				return res.json 501, error: err
			if file.createdBy.id == user._id.id
				return next()
			else res.json 401, error: 'Unauthorzied access'

module.exports =
	field:				field
	order:				order
	order_by:			order_by
	ensurePermission:	ensurePermission