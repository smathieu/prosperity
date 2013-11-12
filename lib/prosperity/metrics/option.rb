module Prosperity
  class Metrics::Option 
    def initialize(name, &block)
      @name = name
      @block = block
    end
  end
end

