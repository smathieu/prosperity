class SubGraph
  constructor: (options) ->
    @url = options.url

  render: ->
    el = $('<div>', class: 'sub-graph')
    el.append("<div class='title'>Loading...</div>")
    chartEl = $('<div>', class: 'sub-graph-chart')
    el.append(chartEl)

    getSeries = (url) =>
      $.get url, (json) =>
        el.find('.title').html(json.label)

        chartOptions =
          element: chartEl
          series: []
          xkey: "x"
          ykeys: []
          labels: []

        chartOptions.postUnits = '%' if json.key == 'change'

        chart = new Morris.Line(chartOptions)
        data = []

        start_time = Date.parse(json.start_time)
        for point, i in json.data
          time = start_time + i * json.period_milliseconds
          data[i] ||= {
            x: time
          }
          data[i][json.key] = point

        chart.options.ykeys.push(json.key)
        chart.options.labels.push(json.key)

        chart.setData data.slice(), redraw = true

    getSeries(@url)
    el


class Graph
  constructor: (options) ->
    @url = options.url
    @el = options.el
    @$el = $(options.el)

  render: =>
    $.getJSON @url, (json) =>
      for extractor, index in json.extractors
        subgraph = new SubGraph(url: extractor.url)
        el = subgraph.render()
        @$el.append(el)
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
  

