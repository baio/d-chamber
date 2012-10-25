request = require "request"

#req - sourceRequest structure {uri : uri}

exports.request = (req, onDone) ->

  request req, (err, resp, body) -> onDone err, body

