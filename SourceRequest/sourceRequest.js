// Generated by CoffeeScript 1.3.3
(function() {
  var webSourceRequest;

  webSourceRequest = require("./webSourceRequest");

  exports.get = function(type) {
    switch (type) {
      case "web":
        return webSourceRequest;
    }
  };

}).call(this);