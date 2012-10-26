// Generated by CoffeeScript 1.3.3
(function() {

  exports.parse = function(parser, source) {
    var i, line, mx, _i, _len, _ref;
    mx = [];
    _ref = source.split('\n').slice(parser.offset);
    for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
      line = _ref[i];
      line = line.replace(/[\r\n]/g, "").toLocaleLowerCase();
      if (line) {
        mx[i] = line.split(parser.separator);
      }
    }
    return mx;
  };

}).call(this);
