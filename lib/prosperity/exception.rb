module Prosperity
  class Exception < ::Exception
  end

  class MissingScope < Exception
    def initialize
      super "You must specify a scope for all metrics."
    end
  end
end

