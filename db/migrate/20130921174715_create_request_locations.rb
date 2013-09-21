class CreateRequestLocations < ActiveRecord::Migration
  def change
    create_table :request_locations do |t|
      t.string :ip_address
      t.string :address
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
