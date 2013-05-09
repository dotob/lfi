$(document).ready ->
  $("#start").focus()
  if $("#jobcount").length
    setInterval updateJobCount, 1000

updateJobCount = () ->
  url = "/sidekiq_queue_jobcount"
  $.getJSON url, (results) ->
    queue = $("#jobcount").attr("data-queue-name")
    count = results[queue]
    unless count then count = 0
    $("#jobcount").text("#{count} jobs")
