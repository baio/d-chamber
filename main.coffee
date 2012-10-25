country = require "./country"

ctry = new country.Country()

ctry.populateStorage(

  {type : "web", uri : "http://www.iso.org/iso/country_names_and_code_elements_txt"}

  {parser : {type : "csv", offset : 1, separator : ';'}, fields : {code : 1, name : 0}}

  {type : "mongo", uri : "mongodb://baio:prodigy123@ds037837.mongolab.com:37837/dchamber", collection : "countries"} , (err) -> console.log err)