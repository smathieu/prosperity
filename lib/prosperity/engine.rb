module Prosperity
  class Engine < ::Rails::Engine
    isolate_namespace Prosperity
    config.autoload_paths << File.expand_path("../../", __FILE__)
    config.after_initialize do
      require "prosperity/exception"
    end
  end
end
