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
#= require highcharts
#= require twitter/bootstrap
#= require_tree .

$ ->
  $(".metric").each (i, el) ->
    $el = $(el)
    points = $(el).data('points')

    series = []

    for key, data of points
      series.push
        data: data
        name: key
          
    $el.highcharts
      chart:
        type: 'line'
      series: series
      yAxis: 
        min: 0
      title: 
        text: $el.data('title'),
        x: -20 
      

    

