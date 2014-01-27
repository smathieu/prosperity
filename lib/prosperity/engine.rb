module Prosperity
  class Engine < ::Rails::Engine
    isolate_namespace Prosperity
    config.autoload_paths << File.expand_path("../../", __FILE__)
    config.after_initialize do
      require "prosperity/exception"
    end

    config.generators do |g|
      g.test_framework :rspec, :fixtures => false
      g.view_specs false
      g.fixture_replacement nil
    end

    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end
  end
end
