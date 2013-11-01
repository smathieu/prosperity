module Prosperity
  class Period < Struct.new(:db_strf_str, :ruby_strf_str, :duration)
    def each_period(start_time, end_time)
      while start_time < end_time
        yield start_time
        start_time += duration
      end
    end
  end
end

