module Prosperity
  class Aggregate::Average < Aggregate::WithColumn
    def to_sql
      "AVG(#{column})"
    end

    def apply(scope, options = {})
      scope.average(column)
    end
  end
end

