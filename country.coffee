async = require "async"
sourceRequest = require "./SourceRequest/sourceRequest"
sourceParser = require "./SourceParser/sourceParser"
freebase = require "./Freebase/freebase"
storage = require "./Storage/storage"

class Country

  ###
  iso - iso data request structure {req : request}
  iso_parse - iso parse structure {parser : sourceParser, fields : {code : int, name : int}}
  fields.code, fields.name - indexes of respective columns
  store - storage  access structure {uri : uri, collection : string, type : "mongo"}
  storage result structure : {_id : iso.code, name : iso.name, fullName, alias : [freebase.alias]}
  ###
  populateStorage: (iso, iso_parse, store, onDone) ->

    async.waterfall [

      #get source data
      (ck) ->
        sourceRequest.get(iso.type).request iso, ck

      #compile countries
      (source, ck) =>
        @_compile iso_parse, source, ck

      #write to store
      (countries, ck) =>
        @_write store, countries, ck

      ], onDone

  _compile: (iso_parse, source, onDone) ->
    #m x n
    columns = sourceParser.get(iso_parse.parser.type).parse iso_parse.parser, source

    countries = []

    #initalize result columns from source
    for r in columns

      countries.push _id : r[iso_parse.fields.code], name : r[iso_parse.fields.name]

    freebase.getCountries (countries.map (m) -> m.name), (err, freebaseCountries) ->

      if !err

        for c in countries

          fc = freebaseCountries.filter((f) -> f.name.toLowerCase() == c.name)[0]

          if fc

            c.alias = fc.alias

      onDone err, countries

  #insert items to storage
  _write: (store, countries, onDone) ->

    stg = storage.get store.type

    async.waterfall [

      (ck) ->

        stg.open store, ck

      (collection, ck) ->

        async.forEach countries, ((c, cb) -> stg.insert c, cb),  ck

      ], (err) ->

        stg.close()

        onDone err

exports.Country = Country






