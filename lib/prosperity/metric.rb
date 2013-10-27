module Prosperity
  class Metric 
    def self.scope(&block)
      if block_given?
        @scope = block.call
      else
        @scope
      end
    end

    def group_by
      :created_at
    end

    def scope
      self.class.scope
    end
  end
end

