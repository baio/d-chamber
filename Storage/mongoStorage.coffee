#{uri : uri, collection : string}
async = require "async"
mongo = require "mongodb"

class MongoStorage

  open: (store, onDone) ->

    if @_collection then throw "collection is already opened"

    config =  conn.str2config @config

    async.waterfall [

      (ck) ->

        db = new mongo.DB config.database, new mongo.Server(config.host, config.port, {})

        db.open ck

      (db, ck) =>

      if config.user

          db.authenticate config.user, config.pass, ck

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

