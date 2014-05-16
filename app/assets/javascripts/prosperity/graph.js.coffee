
class Graph
  constructor: (option) ->
    @url = option.url
    @el = option.el
    @$el = $(option.el)

  render: ->
    chartOptions =
      element: @el
      series: []
      xkey: "x"
      ykeys: []
      labels: []

    data = []

    chart = new Morris.Line(chartOptions)

    getSeries = (config, url, axisIndex) =>
      $.get url, (json) =>
        start_time = Date.parse(json.start_time)
        for point, i in json.data
          time = start_time + i * json.period_milliseconds
          data[i] ||= {
            x: time
          }
          data[i][json.key] = point


        console.log(config)
        console.log(chart.data)
        chart.options.ykeys.push(json.key)
        chart.options.labels.push(json.key)

        chart.setData data.slice(), redraw = true

        # axisIndex = Math.min(axisIndex, chart.yAxis.length - 1)
        # serie = 
        #   data: json.data
        #   name: json.label
        #   yAxis: axisIndex
        #   pointStart: Date.parse(json.start_time)
        #   pointInterval: json.period_milliseconds

        # axisSettings = 
        #   title: {text: json.key}
        #   min: Math.min.apply(Math, json.data)
        #   max: Math.max.apply(Math, json.data)

        # if json.key == 'change'
        #   axisSettings = $.extend axisSettings, {
        #     min: 0,
        #     max: Math.max.apply(Math, json.data),
        #     labels: {formatter: -> this.value + '%' },
        #     opposite: true
        #   }

        #   serie = $.extend serie, {
        #     tooltip: {valueDecimals: 2, valueSuffix: '%'}
        #   }

        # chart.yAxis[axisIndex].update(axisSettings)
        # chart.addSeries(serie)

    $.getJSON @url, (json) ->
      #chart.setTitle {text: json.title}

      for extractor, index in json.extractors
        getSeries(json, extractor.url, index)
        
    @
  
@Prosperity ||= {}
@Prosperity.Graph = Graph

updateMetricOptions = (el) ->
  $el = $(el)
  return if $el.length == 0
  $form = $el.parents('form')
  options = $form.data('metric-options')
  possibleOptions = options[$el.val()] || []

  $optionSelect = $el.parents(".graph-line").find(".metric-option-select select")
  selectedOption = $form.find("input[type=\"hidden\"][name=\"#{$optionSelect.attr('name')}\"]").val()

  $optionSelect.html('')
  for option in possibleOptions
    $optionSelect.append $('<option>', value: option, text: option, selected: selectedOption == option)

$(document).on "change", ".edit_graph .metric-title-select select", (e) ->
  updateMetricOptions e.target

$ ->
  $(".edit_graph .metric-title-select select").each (i, el) ->
    updateMetricOptions el
  

