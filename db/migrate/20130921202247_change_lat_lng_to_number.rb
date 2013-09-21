class ChangeLatLngToNumber < ActiveRecord::Migration
  def change
    remove_column :kids, :latitude
    remove_column :kids, :longitude
    add_column :kids, :latitude, :float
    add_column :kids, :longitude, :float
  end
end
