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

    def self.option(name, &block)
      @options ||= default_options
      if block_given?
        @options[name] = Metrics::Option.new(name, &block)
      else
        raise MissingScope.new 
      end
    end

    def self.options
      @options ||= default_options
    end

    def self.extractors
      [Extractors::Group, Extractors::Count, Extractors::Change].inject({}) do |h, ext|
        h[ext.key] = ext
        h
      end
    end

    def extractors
      self.class.extractors.values
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

    def id
      self.class.name
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

