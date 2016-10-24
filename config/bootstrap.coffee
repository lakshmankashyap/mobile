module.exports =
  bootstrap: (cb) ->
    if process.env.CA
      require 'ssl-root-cas'
        .inject()
        .addFile process.env.CA
    cb()
