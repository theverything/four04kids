class AddFullAddressToKid < ActiveRecord::Migration
  def change
    add_column :kids, :address, :string
    add_column :kids, :latitude, :string
    add_column :kids, :longitude, :string
  end
end
