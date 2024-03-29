async = require "async"
request = require "request"
config = require("../config").config



#countries - countries names (string list)
#returns {name : string, alias : [string]}
exports.getCountries = (countries, onDone) ->

  freebaseCountries = []

  async.forEach countries, (country, ck) ->

    request url : 'https://www.googleapis.com/freebase/v1/mqlread?query={"type":"/location/country","name":"' + country + '","/common/topic/alias":[]}&key=' + config.freebase.key , (err, resp, body) ->

      body = body.replace /\n/, "" if body

      json = JSON.parse(body)

      if !json.error and json.result

        freebaseCountries.push name : json.result.name, alias : json.result["/common/topic/alias"]

      ck json.error

  , (err, ck) ->

      onDone err, freebaseCountries

