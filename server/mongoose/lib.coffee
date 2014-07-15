model = require '../../model.coffee'
_ = require 'underscore'
_.str = require 'underscore.string'	
_.mixin _.str.exports()

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
		domain = p.split(':')[0]
		if p == "#{domain}:create" or p == "#{domain}:list"
			return next()

		model[_.capitalize(domain)].findById req.params.id, (err, data) ->
			if err or data == null
				return res.json 501, error: err
			if data.createdBy.id == req.user._id.id
				return next()
			else res.json 401, error: 'Unauthorzied access'

module.exports =
	field:				field
	order:				order
	order_by:			order_by
	ensurePermission:	ensurePermission