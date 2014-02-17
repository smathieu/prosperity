module Prosperity
  class Aggregate 
    attr_reader :column, :type

    def initialize(type = nil, &block)
      @type = type
      instance_eval(&block) if block_given?
    end

    def sum(column)
      @type = :sum
      @column = column
    end
  end
end

