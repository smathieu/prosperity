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
    url = $el.data('url')

    highchartsOptions = 
      chart:
        type: 'line'
      series: []
      yAxis: 
        min: 0
      title: 
        text: "Loading...",
        x: -20 

    update = ->
      $el.highcharts(highchartsOptions)

    $.getJSON url, (json) ->
      highchartsOptions.title.text = json.title

      for extractor in json.extractors
        $.get extractor.url, (json) ->
          serie = 
            data: json.data
            name: json.key
          highchartsOptions.series.push(serie)
          update()

      update()
        
