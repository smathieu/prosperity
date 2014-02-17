# Create a dummy schema for testing
class User < ActiveRecord::Base
end

RSpec.configure do |config|
  config.before(:suite) do
    m = ActiveRecord::Migration
    m.verbose = false

    m.drop_table :users if ActiveRecord::Base.connection.tables.include?("users") 

    m.create_table :users do |t|
      t.string :email
      t.string :name
      t.integer :value
      t.timestamps
    end
  end
end
