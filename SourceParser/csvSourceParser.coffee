#parse structure {offset : int, separator : char}

#starts parse with offset line
exports.parse = (parser, source) ->

  mx = []

  for line, i in source.split('\n')[parser.offset..]

    line = line.replace(/[\r\n]/g, "").toLocaleLowerCase()

    if line

      mx[i] = line.split parser.separator

  mx



