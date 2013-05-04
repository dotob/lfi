$(document).ready ->
  $("#searchterm").focus()
  $("#searchterm").keyup ->
    $(".resultrow").remove()
    $("#result_count").text("nix gefunden")
    searchterm = $(this).val()
    if searchterm.length > 0
      throttled_search searchterm
    

# render a table row
fill = (context) ->
  t = HandlebarsTemplates[table_row_template()](context);
  $(t).appendTo("#results")

# do searchrequest to searchservice
search = (searchterm) ->
  l = limit()
  url = "/#{search_type()}/#{l}/#{searchterm}"
  $.getJSON url, (results) ->
    count = results.length
    elips = ""
    elips = "..." if count == l 
    $("#result_count").text("gefunden (#{count}#{elips})")
    $.each results, (k, v)->
      fill v

# find which search to query
search_type = () ->
  $("#searchterm").attr("data-search")

# find which template to use for table
table_row_template = () ->
  $("#results").attr("data-row-template")

# find out how many results to return
limit = () ->
  if $("#limit100").hasClass("active")
    return 100
  else if $("#limit1000").hasClass("active")
    return 1000
  else
    return -1

# make search throttled (do not consider every keypress)
throttled_search = _.throttle search, 500
