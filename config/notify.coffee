Promise = require 'bluebird'
gcm = require 'node-gcm'
gcmProvider = Promise.promisifyAll new gcm.Sender process.env.GCMKEY
apn = require 'apn'
apnProvider = new apn.Provider
  pfx: process.env.APNPFX
  passphrase: process.env.APNPASS
  production: false
nodemailer = require 'nodemailer'
smtp = Promise.promisifyAll nodemailer.createTransport process.env.SMTPURL

module.exports =
  notify:
    gcm: (device, data) ->
      msg = new gcm.Message()
      msg.addNotification
        title: 'Instant Messaging'
        body: data.message || ' '
        sound: 'default'
      gcmProvider.sendAsync msg, registrationTokens: [device]
    apn: (device, data) ->
      msg = new apn.Notification
        title: data.title
        body: data.message
        sound: 'default'
      apnProvider.send msg, device
    smtp: (email, data) ->
      smtp.sendMailAsync
        to: email
        subject: data.title
        html: "<a href='#{data.url}'>#{data.message}</a>"
