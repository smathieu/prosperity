module Prosperity
  class Extractors::Count < Extractors::Base
    def to_a
      data = []

      period.each_period(start_time, end_time) do |start_time|
        data << @metric.scope.where("#{metric.group_by} < ?", start_time).count
      end

      data
    end
  end
end

