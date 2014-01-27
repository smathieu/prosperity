module Prosperity
  module GraphHelper
    def options_for_extractors
      Prosperity::Metric.extractors.keys.map(&:to_s).sort
    end
  end
end
