module Prosperity
  module MetricsHelper
    def data_for_metric(metric)
      ext = DataExtractor.new(metric, 12.month.ago, Time.now, Prosperity::Periods::MONTH)
      ext.to_a
    end
  end
end
