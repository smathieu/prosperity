module Prosperity
  class Aggregate::Sql < Aggregate::Base
    def initialize(sql)
      @sql = sql
    end

    def to_sql
      @sql
    end
  end
end

