module Prosperity
  class Period < Struct.new(:strf_str, :duration)
    def each_period(start_time, end_time)
      while start_time < end_time
        yield start_time
        start_time += duration
      end
    end
  end

  class Periods
    MONTH = Period.new("%Y-%m", 1.month)
  end
end

