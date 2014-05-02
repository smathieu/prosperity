module Prosperity
  class Period < Struct.new(:db_strf_str, :ruby_strf_str, :duration, :floor_date, :ceil_date)
    def each_period(start_time, end_time)
      start_time = actual_start_time(start_time)
      end_time = actual_end_time(end_time) + 1
      while start_time <= end_time
        yield start_time
        start_time += duration
      end
    end

    def actual_start_time(start_time)
      floor_date.call(start_time)
    end

    def actual_end_time(end_time)
      ceil_date.call(end_time) + 1
    end
  end
end
