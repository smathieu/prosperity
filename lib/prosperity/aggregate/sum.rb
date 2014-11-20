module Prosperity
  class Aggregate::Sum < Aggregate::WithColumn
    def to_sql
      "SUM(#{column})"
    end

    def apply(scope, options = {})
      scope.sum(column)
    end
  end
end

