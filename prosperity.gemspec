$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem"s version:
require "prosperity/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "prosperity"
  s.version     = Prosperity::VERSION
  s.authors     = ["Simon Mathieu"]
  s.email       = ["simon.math@gmail.com"]
  s.homepage    = "https://github.com/smathieu/prosperity"
  s.summary     = "Prosperity easily lets you add a dashboard of arbitrary time series data to your rails app."
  s.description = s.summary

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.0.0"
  s.add_dependency "anjlab-bootstrap-rails", "~> 3.0.0.3"
  s.add_dependency "haml-rails"
  s.add_dependency "chart-js-rails"

  s.add_development_dependency "sqlite3"
end
