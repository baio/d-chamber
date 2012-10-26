country = require "./country"

isoCountryPostProccess = require "./SourcePostProccess/isoCountry"

ctry = new country.Country()

ctry.populateStorage(

  {type : "web", uri : "http://www.iso.org/iso/country_names_and_code_elements_txt"}

  {parser : {type : "csv", offset : 1, separator : ';'}, fields : {code : 1, name : 0}, postProccess : isoCountryPostProccess.postProcess}

  {type : "mongo", uri : "mongodb://baio:prodigy123@ds037837.mongolab.com:37837/dchamber", collection : "countries"} , (err) -> console.log err)