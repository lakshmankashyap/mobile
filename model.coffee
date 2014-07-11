_ = require 'underscore'
env = require './env'
mongoose = require 'mongoose'
findOrCreate = require 'mongoose-findorcreate'
taggable = require 'mongoose-taggable'

mongoose.connect env.dbUrl, { db: { safe: true }}, (err) ->
  	if err
  		console.log "Mongoose - connection error: #{err}"
  	else console.log "Mongoose - connection OK"
	
UserSchema = new mongoose.Schema
	url:			{ type: String, required: true, index: {unique: true} }
	username:		{ type: String, required: true }
	email:			{ type: String }

UserSchema.statics =
	search_fields: ->
		return ['username', 'email']
	ordering_fields: ->
		return ['username', 'email']
	ordering: ->
		return 'username'
	isUser: (oid) ->
		p = @findById(oid).exec()
		p1 = p.then (user) ->
			return user != null
		p1.then null, (err) ->
			return false		
		
UserSchema.methods =
	checkPermission: (perm) ->
		q = @model('Tagperm').find(name: $in: @tags).exec()
		q.then (perms) ->
			_.some perms, (r) ->
				_.some r.permissions, (p) ->
					p = new Permission(p)
					p.implies perm
	checkPermissions: (perms) ->
		promises = _.map perms, (p) ->
			@checkPermission(p)
		Promise.all(promises).done (permitted) ->
			_.all permitted
			
UserSchema.plugin(findOrCreate)
UserSchema.plugin(taggable)

UserSchema.pre 'save', (next) ->
	@addTag(env.role.all)
	@increment()
	next()
User = mongoose.model 'User', UserSchema
	
DeviceSchema = new mongoose.Schema
	regid:			{ type: String, index: {unique: true} }
	model:			{ type: String }
	version:		{ type: String }
	createdBy:		{ type: mongoose.Schema.Types.ObjectId, ref: 'User' }
	
DeviceSchema.statics =
	search_fields: ->
		return ['regid']
	ordering_fields: ->
		return ['regid']
	ordering: ->
		return 'regid'

DeviceSchema.plugin(findOrCreate)

Device = mongoose.model 'Device', DeviceSchema

module.exports = 
	User: 		User
	Device:		Device