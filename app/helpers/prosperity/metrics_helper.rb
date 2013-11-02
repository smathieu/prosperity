module Prosperity
  module MetricsHelper
    def data_for_metric(metric)
      metric.extractors.inject({}) do |h, ext_klass|
        ext = ext_klass.new(metric, 12.month.ago, Time.now, Prosperity::Periods::MONTH)
        h[ext.key] = ext.to_a
        h
      end
    end
  end
end
