$(document).ready ->
  $("#searchterm").focus()
  $("#searchterm").keyup ->
    $(".imageresult").remove()
    $("#image_count").text("nix gefunden")
    searchterm = $(this).val()
    if searchterm.length > 0
      throttled_search searchterm
    

# render a table row
fill = (context) ->
  t = HandlebarsTemplates['image_table_row'](context);
  $(t).appendTo("#images")

# do searchrequest to searchservice
search = (searchterm) ->
  l = limit()
  $.getJSON "/image_search/#{l}/#{searchterm}", (results) ->
    count = results.length
    elips = ""
    elips = "..." if count == l 
    $("#image_count").text("gefunden (#{count}#{elips})")
    $.each results, (k, v)->
      fill v

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
