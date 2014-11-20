ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'pry-byebug'

PROSPERITY_ROOT = File.expand_path("..", __FILE__)

Dir[File.join(PROSPERITY_ROOT, "support/**/*.rb")].each {|f| require f }
TEST_FILES = File.join(PROSPERITY_ROOT, "test_files")

RSpec.configure do |config|
  config.render_views
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.order = 'random'
end
