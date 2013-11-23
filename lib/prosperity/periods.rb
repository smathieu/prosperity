module Prosperity
  class Periods 
    MONTH = Period.new("YYYY-MM", "%Y-%m", 1.month)
    WEEK = Period.new("YYYY-WW", "%Y-%W", 1.week)
    DAY = Period.new("YYYY-MM-DD", "%Y-%m-%d", 1.day)

    ALL = {
      month: MONTH, 
      week: WEEK, 
      day: DAY,
    }.with_indifferent_access.freeze
  end
end

