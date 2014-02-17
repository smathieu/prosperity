module Prosperity
  class Aggregate::Count < Aggregate::Base
    def to_sql
      "COUNT(1)"
    end
  end
end

