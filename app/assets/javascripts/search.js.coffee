$(document).ready ->
# todo: get search stuff from rails...
  for i in [1..10]
    context = { name: "thename", path: "thepath", typ: "thetyp"}
    t = HandlebarsTemplates['image_table_row'](context);
    $(t).appendTo("#images")
