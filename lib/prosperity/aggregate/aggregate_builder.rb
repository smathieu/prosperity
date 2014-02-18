module Prosperity
  class Aggregate::AggregateBuilder 
    attr_reader :block

    def initialize(string = nil, &block)
      raise "Can't specify a string and a block" if string && block_given?

      @string = string
      @block = block
    end

    def build
      res = @string ? @string : instance_eval(&block)
      if res.is_a?(String)
        Aggregate::Sql.new(res)
      else
        res
      end
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

