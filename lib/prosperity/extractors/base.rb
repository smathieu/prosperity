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

    private
    def sql_fragment_to_count_up_to_date(date)
      <<-SQL
        WITH metric_count AS (
          #{metric.sql}
        )
        SELECT COUNT(1) FROM metric_count
        WHERE #{metric.group_by} < '#{date.iso8601}'
      SQL
    end
  end
end
