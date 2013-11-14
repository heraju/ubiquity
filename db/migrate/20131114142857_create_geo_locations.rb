class CreateGeoLocations < ActiveRecord::Migration
  def change
    create_table :geo_locations do |t|
      t.float :lat
      t.float :long
      t.integer :locatable_id
      t.string :locatable_type
      t.string :state

      t.timestamps
    end
  end
end
