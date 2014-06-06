module Prosperity
  module GraphHelper
    def options_for_extractors
      Prosperity::Metric.extractors.keys.map(&:to_s).sort
    end

    def options_for_metric(metrics)
      metrics.map{|m| [m.title, m.id]}.sort_by(&:first)
    end
  end
end
