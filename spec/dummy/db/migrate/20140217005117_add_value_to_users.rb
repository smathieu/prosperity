class AddValueToUsers < ActiveRecord::Migration
  def change
    add_column :users, :value, :integer
  end
end
