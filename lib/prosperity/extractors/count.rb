module Prosperity
  class Extractors::Count < Extractors::Base
    def self.key
      # TODO considerer rename to total?
      "count"
    end

    def to_a
      data = []

      period.each_period(start_time, end_time) do |start_time|
        if metric.sql?
          data << count_up_to_date_with_sql(start_time)
        else
          data << metric.aggregate.apply(scope.where("#{metric.group_by} < ?", start_time))
        end
      end

      data
    end
  end
end
