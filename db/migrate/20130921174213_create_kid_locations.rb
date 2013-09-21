class CreateKidLocations < ActiveRecord::Migration
  def change
    create_table :kid_locations do |t|
      t.string :address
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
