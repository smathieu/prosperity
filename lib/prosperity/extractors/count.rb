module Prosperity
  class Extractors::Count < Extractors::Base
    def self.key
      "count"
    end

    def to_a
      data = []

      period.each_period(start_time, end_time) do |start_time|
        if metric.sql?
          data << count_up_to_date_with_sql(start_time)
        else
          data << scope.where("#{metric.group_by} < ?", start_time).count
        end
      end

      data
    end
  end
end
