util = require 'util'
Promise = require 'bluebird'
gcm = require 'node-gcm'
gcmProvider = Promise.promisifyAll new gcm.Sender process.env.GCMKEY
apn = require 'apn'
apnProvider = new apn.Provider
  pfx: process.env.APNPFX
  passphrase: process.env.APNPASS
nodemailer = require 'nodemailer'
smtp = Promise.promisifyAll nodemailer.createTransport process.env.SMTPURL

module.exports =
  notify:
    gcm: (device, data) ->
      msg = new gcm.Message 
        collapseKey: data.title
        notification:
          tag: data.title
          title: data.title
          body: data.message || ' '
          sound: 'default'
      gcmProvider.sendAsync msg, registrationTokens: [device]
    apn: (device, data) ->
      msg = new apn.Notification
        collapseId: data.title
        title: data.title
        body: data.message
        sound: 'default'
        topic: data.topic || process.env.TOPIC
      apnProvider
        .send msg, device
        .then (res) ->
          if res.failed.length != 0
            throw new Error util.inspect res.failed, depth: null
          res
    smtp: (email, data) ->
      smtp.sendMailAsync
        to: email
        subject: data.title
        html: "<a href='#{data.url}'>#{data.message}</a>"
