class AddItemsCountToLists < ActiveRecord::Migration
  def change
    add_column :lists, :items_count, :integer
    add_column :items, :list_id, :integer
    
    add_index :items, :list_id
  end
end
