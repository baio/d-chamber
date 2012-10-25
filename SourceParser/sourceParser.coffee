csvSourceParser = require "./csvSourceParser"
#returns csv file format
#parse structure {type : "csv"}

#retuns rows x columns array
exports.get = (type) ->

  switch type

    when "csv" then csvSourceParser

