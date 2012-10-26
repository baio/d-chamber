// Generated by CoffeeScript 1.3.3
(function() {
  var MongoStorage, async, connection, mongo;

  async = require("async");

  mongo = require("mongodb");

  connection = require("./mongoConnection");

  MongoStorage = (function() {

    function MongoStorage() {}

    MongoStorage.prototype.open = function(store, onDone) {
      var config,
        _this = this;
      if (this._collection) {
        throw "collection is already opened";
      }
      config = connection.str2config(store.uri);
      return async.waterfall([
        function(ck) {
          var db;
          db = new mongo.Db(config.database, new mongo.Server(config.host, config.port), {
            safe: true
          });
          return db.open(ck);
        }, function(db, ck) {
          if (config.user) {
            return db.authenticate(config.user, config.pass, function(err) {
              return ck(err, db);
            });
          } else {
            return ck(null, db);
          }
        }, function(db, ck) {
          return db.collection(store.collection, ck);
        }
      ], function(err, collection) {
        _this._collection = collection;
        return onDone(err, collection);
      });
    };

    MongoStorage.prototype.insert = function(item, onDone) {
      if (!this._collection) {
        throw "collection is not opened";
      }
      return this._collection.insert(item, {
        safe: true
      }, onDone);
    };

    MongoStorage.prototype.close = function() {
      if (!this._collection) {
        throw "collection is already closed";
      }
      this._collection.db.close();
      return this._collection = null;
    };

    return MongoStorage;

  })();

  exports.Storage = MongoStorage;

}).call(this);
