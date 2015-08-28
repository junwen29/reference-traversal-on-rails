class CreateCities < ActiveRecord::Migration
  def up
    create_table :cities do |t|
      t.string :name_and_cc

      t.timestamps null: false
    end
  end
  
  def down
    drop_table :cities
  end
end
