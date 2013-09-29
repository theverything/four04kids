class AddNewAttributesToKids < ActiveRecord::Migration
  def change
    add_column :kids, :height, :integer
    add_column :kids, :weight, :integer
    add_column :kids, :eye_color, :string
    add_column :kids, :hair_color, :string
    add_column :kids, :race, :string
    add_column :kids, :sex, :string
    add_column :kids, :circumstance, :text
  end
end
