module Prosperity
  class Helpers::Time 
    def self.beginning_of_hour(date)
      DateTime.new(date.year, date.month, date.day, date.hour)
    end

    def self.end_of_hour(date)
      DateTime.new(date.year, date.month, date.day, date.hour) + 1.hour
    end
  end
end

