module Prosperity
  class Aggregate::Builder 
    attr_reader :block

    def initialize(&block)
      @block = block
    end

    def build
      instance_eval &block
    end

    def count
      Aggregate::Count.new
    end

    def sum(column)
      Aggregate::Sum.new(column)
    end

    def maximum(column)
      Aggregate::Maximum.new(column)
    end

    def minimum(column)
      Aggregate::Minimum.new(column)
    end

    def average(column)
      Aggregate::Average.new(column)
    end
  end
end

