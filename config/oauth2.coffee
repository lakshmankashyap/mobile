module.exports =
  oauth2:
    tokenURL: process.env.TOKENURL
    verifyURL: process.env.VERIFYURL
    scope: [
      'User'
      'Mobile'
    ]
