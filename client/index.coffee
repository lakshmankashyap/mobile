require 'jquery'
require 'bootstrap/dist/js/bootstrap'

app = require './app.coffee'
window.app = new app.App()
window.app.start()