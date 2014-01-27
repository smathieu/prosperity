class Dashboards < ActiveRecord::Migration
  def change
    # Note: foreign_key: false is for schema_plus support
    create_table :prosperity_dashboards do |t|
      t.string :title, null: false
      t.boolean :default, null: false
      t.timestamps
    end

    create_table :prosperity_graph_lines do |t|
      t.integer :graph_id, null: false, foreign_key: false
      t.string :option, null: false
      t.string :metric, null: false
      t.string :extractor, null: false
      t.timestamps
    end

    create_table :prosperity_graphs do |t|
      t.string :title, null: false
      t.string :period, null: false
      t.timestamps
    end

    create_table :prosperity_dashboard_graphs do |t|
      t.integer :graph_id, null: false, foreign_key: false
      t.integer :dashboard_id, null: false, foreign_key: false
      t.timestamps
    end

    add_index :prosperity_dashboard_graphs, [:graph_id, :dashboard_id], unique: true
    add_index :prosperity_dashboard_graphs, :dashboard_id
    add_index :prosperity_graph_lines, :graph_id
  end
end
