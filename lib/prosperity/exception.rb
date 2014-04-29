module Prosperity
  class Exception < ::Exception
  end

  class MissingScope < Exception
    def initialize
      super "You have asked for the scope of a metric with no scope."
    end
  end

  class MissingSql < Exception
    def initialize
      super "You have asked for the sql of a metric with no sql."
    end
  end

  class MissingValueAt < Exception
    def initialize
      super "You have asked for the value_at, but none was specified"
    end
  end

  class SqlMetricCannotHaveOption < Exception
    def initialize
      super "Sql metrics cannot have options"
    end
  end
end

