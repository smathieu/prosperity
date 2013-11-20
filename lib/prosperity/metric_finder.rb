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

    def self.find_by_name(name)
      klass = name.constantize

      if klass < Metric
        klass
      else
        nil
      end
    end
  end
end

