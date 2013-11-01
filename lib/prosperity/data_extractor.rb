module Prosperity
  class DataExtractor 
    attr_reader :metric, :start_time, :end_time, :period

    def initialize(metric, start_time, end_time, period)
      @metric, @start_time, @end_time, @period =
        metric, start_time, end_time, period
    end

    def to_a
      s = @metric.scope.where("#{metric.group_by} BETWEEN ? AND ?", @start_time, @end_time)
      s = s.group("to_char(#{metric.group_by}, '#{period.db_strf_str}')").count

      data = []

      period.each_period(start_time, end_time) do |start_time|
        str = start_time.strftime(period.ruby_strf_str)
        puts str
        value = s.has_key?(str) ? s[str].to_f : 0.0
        data << value
      end

      data
    end
  end
end

