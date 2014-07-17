envClient = require './client/env.coffee'
env = require './env.coffee'
path = require 'path'
passport = require 'passport'
bearer = require 'passport-http-bearer'
logger = env.log4js.getLogger('app.coffee')
fs = require 'fs'
http = require 'needle'
_ = require 'underscore'
model = require './model.coffee'
ensureLoggedIn = require('connect-ensure-login').ensureLoggedIn

port = process.env.PORT || 3000

dir = '/etc/ssl/certs'
files = fs.readdirSync(dir).filter (file) -> /.*\.pem/i.test(file)
files = files.map (file) -> "#{dir}/#{file}"
ca = files.map (file) -> fs.readFileSync file

passport.serializeUser (user, done) ->
	done(null, user.id)
	
passport.deserializeUser (id, done) ->
	model.User.findById id, (err, user) ->
		done(err, user)

passport.use 'bearer', new bearer.Strategy {}, (token, done) ->
	opts = 
		ca:		ca
		headers:
			Authorization:	"Bearer #{token}"
	http.get env.oauth2.verifyURL, opts, (err, res, body) ->
		if err?
			return logger.error err
				
		# check required scope authorized or not
		scope = body.scope.split(' ')
		result = _.intersection scope, envClient.oauth2.scope
		if result.length != envClient.oauth2.scope.length
			return done('Unauthorzied access', null)
			
		# create user
		# otherwise check if user registered before (defined in model.User or not)
		user = _.pick body.user, 'url', 'username', 'email'
		model.User.findOrCreate user, (err, user, created) ->
			if err
				return done(err, null)
			done(err, user)

passport.use 'provider', new env.oauth2.provider.Strategy env.oauth2, (token, refreshToken, profile, done) ->
	user =
		url:		profile.id
		username:	profile.displayName
		email:		profile.emails[0].value
	model.User.findOrCreate user, (err, user, created) ->
		if err
			return done(err, null)
		done(err, user)

require('zappajs') port, ->
	@set 'view engine': 'jade'
	# strip url with prefix = env.path 
	@use (req, res, next) ->
		p = new RegExp('^' + envClient.path)
		req.url = req.url.replace(p, '')
		next()
	@use static: __dirname + '/public'
	@use 'logger', 'cookieParser', session:{secret:'keyboard cat'}, 'bodyParser', 'methodOverride'
	@use passport.initialize(), passport.session()
	@use 'zappa'

	@get env.oauth2.authURL, passport.authenticate('provider', scope: env.oauth2.scope)
	
	@get env.oauth2.cbURL, passport.authenticate('provider', scope: env.oauth2.scope), ->
		@response.redirect @session.returnTo
		
	@get '/', ensureLoggedIn(path.join env.path, env.oauth2.authURL), ->
		@render 'index.jade', {path: env.path, title: 'Device'}
		
	@get '/auth/logout', ->
		@request.logout()
		@response.redirect('/')
	
	@include './server/mongoose/url/user.coffee'
	@include './server/mongoose/url/device.coffee'
	@include './server/mongoose/url/gcm.coffee'