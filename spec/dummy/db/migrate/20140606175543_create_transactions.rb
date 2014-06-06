class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.datetime :date, null: false, index: true
      t.integer :amount_in_cents, null: false

      t.timestamps
    end
  end
end
