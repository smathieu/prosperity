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
#= require_tree .

$ ->

  $(".metric").each (i, el) ->
    $el = $(el)
    url = $el.data('url')

    highchartsOptions = 
      chart:
        type: 'line'
        renderTo: el
      tooltip:
        crosshairs: [true, true]
      series: []
      xAxis: 
        type: 'datetime'
        dateTimeLabelFormats:
          day: '%e of %b'
      yAxis: [{}, {}, {}]
      title: 
        text: "Loading..."

    chart = new Highcharts.Chart(highchartsOptions)

    get_series = (url, axis_index) =>
      $.get url, (json) =>
        serie = 
          data: json.data
          name: json.key
          yAxis: axis_index
          pointStart: Date.parse(json.ts_start)
          pointInterval: json.ts_interval

        axis_settings = 
          title: {text: json.key}
          min: Math.min.apply(Math, json.data)
          max: Math.max.apply(Math, json.data)
      

        if json.key == 'change'
          axis_settings = $.extend axis_settings, {
            min: 0,
            max: Math.max.apply(Math, json.data),
            labels: {formatter: -> this.value + '%' },
            opposite: true
          }

          serie = $.extend serie, {
            tooltip: {valueDecimals: 2, valueSuffix: '%'}
          }

        chart.yAxis[axis_index].update(axis_settings)
        chart.addSeries(serie)

    $.getJSON url, (json) ->
      chart.setTitle {text: json.title}

      for extractor, index in json.extractors
        get_series(extractor.url, index)
        
