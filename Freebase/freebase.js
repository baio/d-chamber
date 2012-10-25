// Generated by CoffeeScript 1.3.3
(function() {
  var async, request;

  async = require("async");

  request = require("request");

  exports.getCountries = function(countries, onDone) {
    var freebaseCountries;
    freebaseCountries = [];
    return async.forEach(countries, function(country, ck) {
      return request({
        url: 'https://www.googleapis.com/freebase/v1/mqlread?query={"type":"/location/country","name":"' + country + '","/common/topic/alias":[]}'
      }, function(err, resp, body) {
        var json;
        if (body) {
          body = body.replace(/\n/, "");
        }
        json = JSON.parse(body);
        if (!json.error) {
          freebaseCountries.push({
            name: json.result.name,
            alias: json.result["/common/topic/alias"]
          });
        }
        return ck(json.error);
      });
    }, function(err, ck) {
      return onDone(err, freebaseCountries);
    });
  };

}).call(this);
