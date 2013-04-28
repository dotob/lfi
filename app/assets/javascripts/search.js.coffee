$(document).ready ->
  $("#searchterm").keypress ->
    throttled_search $(this).val()
    

# get search stuff from rails...
fill = (context) ->
  t = HandlebarsTemplates['image_table_row'](context);
  $(t).appendTo("#images")

search = (searchterm) ->
  $.getJSON '/image_search/#{searchterm}', (results) ->
   fill results

throttled_search = _.throttle search, 200
