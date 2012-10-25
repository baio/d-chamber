#{uri : uri, collection : string}
async = require "async"
mongo = require "mongodb"
connection = require "./mongoConnection"

class MongoStorage

  open: (store, onDone) ->

    if @_collection then throw "collection is already opened"

    config =  connection.str2config store.uri

    async.waterfall [

      (ck) ->

        db = new mongo.Db config.database, new mongo.Server(config.host, config.port), { safe : true }

        db.open ck

      (db, ck) =>

        if config.user

            db.authenticate config.user, config.pass, (err) -> ck err, db

          else

            ck null, db

    ,(db, ck) =>

          db.collection store.collection, ck

    ],
      (err, collection) =>

        @_collection = collection

        onDone err, collection


  insert: (item, onDone) ->

    if !@_collection then throw "collection is not opened"

    @_collection.insert item, safe : true, onDone

  close: ->

    if @_collection then throw "collection is already closed"

    @_collection.db.close()

    @_collection = null


exports.Storage = MongoStorage

