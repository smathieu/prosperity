module Prosperity
  class Period < Struct.new(:db_strf_str, :ruby_strf_str, :duration)
    def each_period(start_time, end_time)
      while start_time < end_time
        yield start_time
        start_time += duration
      end
    end

    def to_a(start_time, end_time)
      a = []
      while start_time < end_time
        a << start_time
        start_time += duration
      end
      a
    end
  end
end

