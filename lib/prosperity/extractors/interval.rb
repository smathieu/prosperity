module Prosperity
  class Extractors::Interval < Extractors::Base
    def self.key
      "interval"
    end

    def to_a
      if metric.sql?
        fragment = <<-SQL
          WITH prosperity_metric_count AS (
            #{metric.sql}
          )
          SELECT to_char(#{metric.group_by}, '#{period.db_strf_str}') AS bucket, #{aggregate.to_sql} AS result
          FROM prosperity_metric_count
          WHERE (#{metric.group_by} BETWEEN '#{@start_time.iso8601}' AND '#{@end_time.iso8601}')
          GROUP BY bucket
        SQL
        result = ActiveRecord::Base.connection.execute(fragment)
        s = result.to_a.inject({}) {|accum, el|
          accum.update(el["bucket"] => el["result"].to_f)
        }
      elsif metric.ruby?
        data = []
        period.each_period(start_time, end_time) do |start_time|
          new = metric.value_at.call(start_time, period)
          last = metric.value_at.call(start_time - period.duration, period)

          data << new - last
        end

        return data
      else
        s = scope.where("#{metric.group_by} BETWEEN ? AND ?", @start_time, @end_time)
        s = s.group("to_char(#{metric.group_by}, '#{period.db_strf_str}')")
        s = aggregate.apply(s)
      end


      data = []

      period.each_period(start_time, end_time) do |start_time|
        str = start_time.strftime(period.ruby_strf_str)
        value = s.has_key?(str) ? s[str].to_f : 0.0
        data << value
      end

      data
    end
  end
end

