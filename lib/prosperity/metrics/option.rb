module Prosperity
  class Metrics::Option 
    attr_reader :name, :block

    def initialize(name, &block)
      @name = name
      @block = block
    end

    def to_s
      name
    end
  end
end

