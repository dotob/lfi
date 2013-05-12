# after document loaded completely
$(document).ready ->
  $("#searchterm").focus()
  $("#searchterm").keyup ->
    presearch(limit())
  $(".limit").click ->
    id = $(this).attr("id")
    limitNumberString = id.substring(5,id.length)
    limitNumber = parseInt(limitNumberString)
    presearch(limitNumber)

presearch = (limit) ->
    searchterm = $("#searchterm").val()
    $(".resultrow").remove()
    $("#result_count").text("nix gefunden")
    if searchterm.length > 0
      throttled_search searchterm, limit

# do searchrequest to searchservice
search = (searchterm, limit) ->
  url = "/#{search_type()}/#{limit}/#{searchterm}"
  $.getJSON url, (results) ->
    count = results.items.length
    elips = ""
    elips = "..." if count == limit 
    $("#result_count").text("gefunden (#{count}#{elips})")
    $.each results.items, (k, v)->
      fill v, results.copy_targets

# render a table row
fill = (item, more) ->
  t = HandlebarsTemplates[table_row_template()]({item: item, more: more});
  $(t).appendTo("#results")

# find which search to query
search_type = () ->
  $("#searchterm").attr("data-search")

# find which template to use for table
table_row_template = () ->
  $("#results").attr("data-row-template")

# find out how many results to return
limit = () ->
  if $("#limit10").hasClass("active")
    return 10
  else if $("#limit100").hasClass("active")
    return 100
  else if $("#limit1000").hasClass("active")
    return 1000
  else
    return -1

# make search throttled (do not consider every keypress)
throttled_search = _.throttle search, 500
