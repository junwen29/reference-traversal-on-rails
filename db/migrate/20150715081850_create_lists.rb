class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :name
      t.text :description
      t.integer :user_id

      t.timestamps null: false
    end
    
    add_index :lists, :user_id
    
    add_column :users, :lists_count, :integer 
  end
end
