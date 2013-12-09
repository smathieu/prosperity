module Prosperity
  class Extractors::Base 
    attr_reader :metric, :start_time, :end_time, :period, :option

    def initialize(metric, option, start_time, end_time, period)
      @metric, @option, @start_time, @end_time, @period =
        metric, option, period.floor_date.call(start_time), period.ceil_date.call(end_time), period
    end

    def scope
      @metric.options.fetch(option).block.call(metric.scope)
    end

    def key
      self.class.key
    end
  end
end
