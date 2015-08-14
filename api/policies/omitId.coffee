module.exports = (req, res, next) ->
	req.body = _.omit req.body, 'id', 'updatedAt', 'createdAt', 'createdBy'
	req.query = _.omit req.query, 'id', 'updatedAt', 'createdAt', 'createdBy'
	next()