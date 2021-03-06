module Prosperity
  class Aggregate::Minimum < Aggregate::WithColumn
    def to_sql
      "MIN(#{column})"
    end

    def apply(scope, options = {})
      scope.minimum(column)
    end
  end
end

