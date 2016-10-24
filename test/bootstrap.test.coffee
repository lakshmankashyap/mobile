fs = require 'fs'
config = JSON.parse fs.readFileSync './.sailsrc'

Sails = require 'sails'

before (done) ->
  @timeout process.env.TIMEOUT || 4000000

  Sails.lift config, (err, sails) ->
    if err
      return done err
    
    done err, sails
    
after (done) ->
  Sails.lower done
