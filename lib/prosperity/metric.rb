module Prosperity
  class Metric 
    def self.scope(&block)
      if block_given?
        @scope = block.call
      else
        raise MissingScope.new if @scope.nil?
        @scope
      end
    end

    def extractors
      [Extractors::Group, Extractors::Count]
    end

    def group_by
      :created_at
    end

    def scope
      self.class.scope
    end
  end
end

