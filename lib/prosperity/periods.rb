module Prosperity
  class Periods 
    MONTH = Period.new("YYYY-MM", "%Y-%m", 1.month, ->(start_ts){ start_ts.beginning_of_month }, ->(end_ts){ end_ts.end_of_month })
    WEEK = Period.new("YYYY-WW", "%Y-%W", 1.week, ->(start_ts){ start_ts.beginning_of_week }, ->(end_ts){ end_ts.end_of_week })
    DAY = Period.new("YYYY-MM-DD", "%Y-%m-%d", 1.day, ->(start_ts){ start_ts.at_midnight }, ->(end_ts){ end_ts.at_end_of_day })
    HOUR = Period.new("YYYY-MM-DD-H", "%Y-%m-%d-%h", 1.hour, 
                      ->(start_ts){ Helpers::Time.beginning_of_hour(start_ts) }, 
                      ->(end_ts){ Helpers::Time.end_of_hour(end_ts) })

    ALL = {
      month: MONTH, 
      week: WEEK, 
      day: DAY,
      hour: HOUR,
    }.with_indifferent_access.freeze
  end
end
