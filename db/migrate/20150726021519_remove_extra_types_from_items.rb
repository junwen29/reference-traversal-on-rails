class RemoveExtraTypesFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :maxTemp, :integer
    remove_column :items, :minTemp, :integer
    remove_column :items, :itemType, :string
    add_column :items, :quantity, :integer
  end
end
