# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require jquery_ujs
#= require chart
#= require twitter/bootstrap
#= require_tree .

$ ->
  $("canvas.metric").each (i, el) ->
    ctx = el.getContext("2d")
    points = $(el).data('points')

    datasets = []

    size = 0
    for key, data of points
      datasets.push
        data: data
        fillColor : "rgba(151,187,205,0)",
        strokeColor : "rgba(0,0,0,1)",
          

      size = Math.max(size, data.length)
        
    data = 
      labels : (i for i in [0..size])
      datasets: datasets

    options = 
      bezierCurve: false

    myNewChart = new Chart(ctx).Line(data, options)
    

