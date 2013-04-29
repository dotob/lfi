$(document).ready ->
  $("#searchterm").focus()
  $("#searchterm").keyup ->
    $("#images.tr").remove()
    #throttled_search $(this).val()
    search $(this).val()
    

# get search stuff from rails...
fill = (context) ->
  t = HandlebarsTemplates['image_table_row'](context);
  $(t).appendTo("#images")

search = (searchterm) ->
  $.getJSON "/image_search/#{searchterm}", (results) ->
    $.each results, (k, v)->
      fill v

throttled_search = _.throttle search, 200
