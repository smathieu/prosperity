module Prosperity
  class Extractors::Change < Extractors::Base
    def self.key
      'change'
    end

    def to_a
      data = []

      period.each_period(start_time, end_time) do |start_time|
        new = scope.where("#{metric.group_by} < ?", start_time).count
        last = scope.where("#{metric.group_by} < ?", start_time - period.duration).count

        change = if last > 0
                   ((new.to_f / last) - 1.0) * 100
                 else
                   0.0
                 end

        data << change
      end

      data
    end
  end
end

