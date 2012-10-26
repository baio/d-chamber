country = require "../country"
config = require("../config").config

isoCountryPostProccess = require "../SourcePostProccess/isoCountry"

exports.populate = (onDone) ->

  ctry = new country.Country()

  ctry.populateStorage(

    {type : "web", uri : "http://www.iso.org/iso/country_names_and_code_elements_txt"}

    {parser : {type : "csv", offset : 1, separator : ';'}, fields : {code : 1, name : 0}, postProccess : isoCountryPostProccess.postProcess}

    {type : "mongo", uri : config.mongo.uri, collection : "countries"} , onDone)