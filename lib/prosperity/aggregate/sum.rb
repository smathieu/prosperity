module Prosperity
  class Aggregate::Sum < Aggregate::Base
    attr_reader :column

    def initialize(column)
      @column = column
    end

    def to_sql
      "COUNT(#{column})"
    end
  end
end

