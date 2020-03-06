class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.integer :zip
      t.string :name
      t.text :weather_data

      t.timestamps
    end
  end
end
