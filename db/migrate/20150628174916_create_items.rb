class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :season
      t.string :itemType
      t.integer :minTemp
      t.integer :maxTemp

      t.timestamps null: false
    end
  end
end
