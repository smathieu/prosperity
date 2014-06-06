module Prosperity
  module GraphHelper
    def options_for_extractors
      Prosperity::Metric.extractors.keys.map(&:to_s).sort
    end

    def options_for_metric(metrics)
      metrics.map{|m| [m.title, m.id]}.sort_by(&:first)
    end

    def render_graph(graph, options = {})
      path_opts = options.slice(:start_time)
      path = case graph
      when Graph
        graph_path(graph, path_opts)
      when Metric
        metric_path(graph, path_opts)
      else
        raise "Unsupported object #{graph.class}"
      end
      classes = [Array(options[:class]) + ['metric']].flatten.uniq
      render partial: "prosperity/graphs/render_graph", locals: {
        graph: graph,
        classes: classes,
        path: path,
      }
    end
  end
end
