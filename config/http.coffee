module.exports = 
	http:
		middleware:
			order: [
				'startRequestTimer'
				'cookieParser'
				'session'
				'bodyParser'
				'compress'
				'methodOverride'
				'$custom'
				'router'
				'static'
				'www'
				'favicon'
				'404'
				'500'
			]