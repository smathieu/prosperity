module Prosperity
  class Extractors::Base 
    attr_reader :metric, :start_time, :end_time, :period

    def initialize(metric, start_time, end_time, period)
      @metric, @start_time, @end_time, @period =
        metric, start_time, end_time, period
    end
  end
end

