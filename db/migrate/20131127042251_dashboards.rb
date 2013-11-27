class Dashboards < ActiveRecord::Migration
  def change
    create_table :properity_dashboards do |t|
      t.string :name, null: false
      t.boolean :default, null: false
      t.timestamps
    end

    create_table :properity_metrics do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :properity_views do |t|
      t.integer :metric_id, null: false
      t.string :period, null: false
      t.string :option, null: false
      t.timestamps
    end

    create_table :properity_dashboard_views do |t|
      t.integer :view_id, null: false
      t.integer :dashboard_id, null: false
      t.timestamps
    end
  end
end
