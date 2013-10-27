module Prosperity
  require "prosperity/exception"

  class Engine < ::Rails::Engine
    isolate_namespace Prosperity
    config.autoload_paths << File.expand_path("../../", __FILE__)
  end
end
