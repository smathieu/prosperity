module Prosperity
  class Aggregate::Sum < Aggregate::Base
    attr_reader :column

    def initialize(column)
      @column = column
    end

    def to_sql
      "SUM(#{column})"
    end

    def apply(scope)
      scope.sum(column)
    end
  end
end

