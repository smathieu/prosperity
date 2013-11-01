module Prosperity
  class MetricFinder < Struct.new(:directory)
    def metrics
      Dir[File.join(directory, "**/*_metric.rb")].map do |metric|
        File.basename(metric, ".rb").camelcase.constantize
      end
    end

    def self.all
      self.new(File.join(Rails.root, "app/prosperity")).metrics
    end
  end
end

