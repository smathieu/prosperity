module Prosperity
  module MetricsHelper
    def data_for_metric(metric)
      metric.extractors.inject({}) do |h, ext_klass|
        option = params.fetch(:option, 'default')
        end_time = Time.now
        start_time = end_time - 12.months
        ext = ext_klass.new(metric, option, start_time, end_time, Prosperity::Periods::MONTH)
        h[ext.key] = ext.to_a
        h
      end
    end
  end
end
