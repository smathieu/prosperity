module Prosperity
  class Extractors::Total < Extractors::Base
    def self.key
      "total"
    end

    def to_a
      data = []

      period.each_period(start_time, end_time) do |start_time|
        if metric.sql?
          data << count_up_to_date_with_sql(start_time)
        elsif metric.ruby?
          data << metric.value_at.call(start_time, period)
        else
          data << metric.aggregate.apply(scope.where("#{metric.group_by} < ?", start_time))
        end
      end

      data
    end
  end
end
