webSourceRequest = require "./webSourceRequest"



exports.get = (type) ->

  switch type
    when "web" then webSourceRequest

