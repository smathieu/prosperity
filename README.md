# Prosperity

[![Build Status](https://travis-ci.org/smathieu/prosperity.png)](https://travis-ci.org/smathieu/prosperity)

Prosperity easily lets you add a dashboard of arbitrary time series data to your rails app. Is lets you easily graph anything that changes over time using your existing ActiveRecord scopes or raw SQL.

This is still a work in progress, but it should already make it much easier to create dashboard withing your Rails app. Currently only tested with PostgreSQL, but should be easily portable to other DBs.

![Screenshot](https://raw2.github.com/smathieu/prosperity/master/doc/screenshot.png "Prosperity")

## Install

Add this line to your application's Gemfile:

```
gem 'prosperity'
```

And then execute:

```bash
bundle
bundle exec rake db:migrate
```

Add a route to prosperity in ```config/routes.rb```.

```ruby
mount Prosperity::Engine => "/prosperity"
```

## Usage

You can then generate your first metric.

```bash
rails g metric Users
```

This will generate app/prosperity/user_metric.rb

You can add custom scopes like so:

```ruby
class UsersMetric < Prosperity::Metric
  scope { User }

  options 'active' do |scope|
    scope.where(state: 'active')
  end
end
```

By default, Prosperity will return a count of object grouped by period. You can also use other aggragation function such as `minimum`, `maximum`, `average` and `sum`.

You can use them as follow:


```ruby
class UsersMetric < Prosperity::Metric
  scope { User.join(:subsriptions) }
  aggregate { sum(:price_in_cents) }
end
```

### SQL support

Prosperity also supports raw SQL in queries. 

```ruby
class UsersMetric < Prosperity::Metric
  sql "SELECT * FROM users"
  group_by "created_at"
  aggregate { "SUM(value)" }
end
```

Unfortunately, there's currently a few limitations to SQL bases queries. PR to fix those are more than welcome :)

## Ruby support

Sometime it's hard to get the data you want in plain SQL, or you might want to get data from somewhere other than your DB, like a from an API. 

The ruby syntax is a way for you to define the value or something for a given point in the graph. This should return the total value of the metric you want to measure and the change and interval and change metrics will be calculated from that value.

Currently, there's no support for options, although this will likely change in the future.

```ruby
class RubyUsersMetric < Prosperity::Metric
  value_at do |time, period, *|
    User.where("users.created_at <= ?", time).count
  end
end
```

## Development

To get started with a development environment with [pow](http://pow.cx/), follow these instructions;

```bash
git clone https://github.com/smathieu/prosperity.git
ln -s `pwd`/prosperity/spec/dummy ~/.pow/prosperity
cd prosperity
bundle
rake db:create db:migrate RAILS_ENV=test
rake db:seed
```

and to run the tests;

```bash
bundl exec rspec
```

## License

This project rocks and uses MIT-LICENSE.

## TODO

See [Issues](https://github.com/smathieu/prosperity/issues?labels=enhancement&page=1&state=open)
