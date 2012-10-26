exports.postProcess = (item) ->

  parts = item.name.split ","

  if parts.length == 2

    item.name = parts[0].trim()

    item.alias = [ parts[1].trim() + " " + parts[0].trim() ]

  switch item.name.toLowerCase()
    when "united states"
      item.name  = "united states of america"

  item