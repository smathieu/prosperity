# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.

$(".link-graph").submit (e) ->
  $form = $(e.target)
  dashboard_id = $form.find("#dashboard_id").val()
  graph_id = $form.find("#graph_id").val()
  url_template = $form.find("#url_template").val()

  url = url_template.replace("dashboard_id", dashboard_id)
  url = url.replace("graph_id", graph_id)
  #"/dashboards/#{dashboard_id}/graphs/#{graph_id}"
  if $form.attr('action') != url
    e.preventDefault()
    $form.attr('action', url)
    $form.submit()
    
