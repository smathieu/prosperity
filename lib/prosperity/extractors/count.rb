module Prosperity
  class Extractors::Count < Extractors::Base
    def self.key
      "count"
    end

    def to_a
      data = []

      period.each_period(start_time, end_time) do |start_time|
        if metric.sql?
          fragment = sql_fragment_to_count_up_to_date(start_time)
          result = ActiveRecord::Base.connection.execute(fragment)
          data << result.to_a.first["count"].to_i
        else
          data << scope.where("#{metric.group_by} < ?", start_time).count
        end
      end

      data
    end
  end
end
