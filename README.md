# Prosperity

[![Build Status](https://travis-ci.org/smathieu/prosperity.png)](https://travis-ci.org/smathieu/prosperity)

Prosperity easily lets you add a dashboard of arbitrary time series data to your rails app.

## Install

Add this line to your application's Gemfile:

    gem 'lib-generator'

And then execute:

    $ bundle

Add a route to prosperity.

    mount Prosperity::Engine => "/prosperity"

You can then generate your first metric.

    rails g metric User    

This will generate app/prosperity/user_metric.rb

You can add custom scopes like so:

    class UsersMetric < Prosperity::Metric
      scope { User }
    
      options 'active' do |scope|
        scope.where(state: 'active')
      end
    end

## License

This project rocks and uses MIT-LICENSE.

## Todo

- Better Docs
- Select data range
- Export data to CSV
- Graph % change since last value
- Dashboard
