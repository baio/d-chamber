mongoStorage = require "./mongoStorage"

#{type : "mongo"}
exports.get = (type) ->

  switch type

    when "mongo" then mongoStorage.Storage

