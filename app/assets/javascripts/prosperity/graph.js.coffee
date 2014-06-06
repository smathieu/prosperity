class SubGraph
  constructor: (options = {}) ->
    @el = $('<div>', class: 'sub-graph')
    graphType = @graphType = options.graphType

    if options.showTitle
      @el.append("<div class='title'>Loading...</div>")

    @el.find('.title').html(options.label)

    chartEl = $('<div>', class: 'sub-graph-chart')
    @el.append(chartEl)

    hoverCallback = (index, options, content, data) ->
      if graphType == 'area'
        data = options.data[index]

        sum = 0
        for key, value of data
          sum += value unless key == 'x'

        t = "Total: #{sum}"

        content += t

      content

    @data = []
    @chartOptions =
      element: chartEl
      series: []
      xkey: "x"
      ykeys: []
      labels: []
      smooth: false
      data: @data
      hideHover: true
      hoverCallback: hoverCallback
      events: [new Date().toISOString()]

    @chartOptions.postUnits = '%' if options.key == 'change'

  addSeries: (json) ->
    data = @data

    start_time = Date.parse(json.start_time)
    for point, i in json.data
      time = start_time + i * json.period_milliseconds
      data[i] ||= {
        x: time
      }
      data[i][json.uid] = point

    @chartOptions.ykeys.push(json.uid)
    @chartOptions.labels.push(json.uid)

    @el

  class: =>
    if @graphType == 'area'
      Morris.Area
    else
      Morris.Line

  draw: ->
    # Because of a bug in Morris (https://github.com/morrisjs/morris.js/issues/388) 
    # it's not possible to add data on a hidden element. We just redraw the
    # entire thing in the meantime.
    @chart = new @class()(@chartOptions)

class Graph
  constructor: (options) ->
    @url = options.url
    @el = options.el
    @$el = $(options.el)

  render: =>
    $.getJSON @url, (json) =>
      for extractor, index in json.extractors
        $.get extractor.url, (line_json) =>
          subgraph = @getSubgraph
            label: line_json.label
            key: line_json.key
            graphType: json.graph_type

          subgraph.addSeries(line_json)

          if @$el.hasClass('dashboard')
            if subgraph.chartOptions.ykeys.length == json.extractors.length
              subgraph.draw()
          else
            subgraph.draw()

    @

  getSubgraph: (options) =>
    create = (options) => 
      subgraph = new SubGraph(options)
      @$el.append(subgraph.el)
      subgraph

    # Render 1 subgraph if it's a dashboard graph, mulltiple otherwise.
    if @$el.hasClass('dashboard')
      @subGraph ||= create(options)
    else
      create($.extend(options, showTitle: true))

@Prosperity ||= {}
@Prosperity.Graph = Graph

updateMetricOptions = (el) ->
  $el = $(el)
  return if $el.length == 0
  $form = $el.parents('form')
  options = $form.data('metric-options')
  possibleOptions = options[$el.val()] || []
  possibleOptions = possibleOptions.sort()

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

