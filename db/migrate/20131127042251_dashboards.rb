class Dashboards < ActiveRecord::Migration
  def change
    create_table :prosperity_dashboards do |t|
      t.string :title, null: false
      t.boolean :default, null: false
      t.timestamps
    end

    create_table :prosperity_metrics do |t|
      t.integer :view_id, null: false
      t.string :name, null: false
      t.timestamps
    end

    create_table :prosperity_views do |t|
      t.string :period, null: false
      t.string :option, null: false
      t.timestamps
    end

    create_table :prosperity_dashboard_views do |t|
      t.integer :view_id, null: false
      t.integer :dashboard_id, null: false
      t.timestamps
    end

    add_index :prosperity_metrics, :view_id
    add_index :prosperity_dashboard_views, :view_id
    add_index :prosperity_dashboard_views, :dashboard_id
  end
end
