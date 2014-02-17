module Prosperity
  class Aggregate::WithColumn 
    attr_reader :column

    def initialize(column)
      @column = column
    end
  end
end

