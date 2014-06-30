source "https://rubygems.org"

# Declare your gem's dependencies in prosperity.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'debugger'

gem "sass-rails"
gem "coffee-rails"
gem "jquery-rails"

group :development, :test do
  gem "rspec-rails", "2.99.0"
  gem "pry-debugger"
  gem "awesome_print"
end

group :development do
  gem "lib-generator"
end

group :test do
  gem "shoulda-matchers"
end
