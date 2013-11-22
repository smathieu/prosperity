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

    def self.options(name = nil, &block)
      @options ||= default_options
      if block_given?
        @options[name] = Metrics::Option.new(name, &block)
      else
        raise MissingScope.new if @options.nil?
        @options
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

    def options
      self.class.options
    end

    def title
      self.class.to_s.gsub(/Metric$/, "").titleize
    end

    private

    def self.default_options
      o = Metrics::Option.new("default") do |scope|
        scope
      end
      {"default" => o}
    end
  end
end

