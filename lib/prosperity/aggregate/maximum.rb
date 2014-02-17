module Prosperity
  class Aggregate::Maximum < Aggregate::WithColumn
    def to_sql
      "MAX(#{column})"
    end

    def apply(scope)
      scope.maximum(column)
    end
  end
end

