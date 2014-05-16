class AddGraphTypeToGraphs < ActiveRecord::Migration
  def up
    add_column :prosperity_graphs, :graph_type, :string
    execute "UPDATE prosperity_graphs SET graph_type='line'"
    change_column :prosperity_graphs, :graph_type, :string, null: false
  end

  def down
    remove_column :prosperity_graphs, :graph_type, :string
  end
end
