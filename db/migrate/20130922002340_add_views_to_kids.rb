class AddViewsToKids < ActiveRecord::Migration
  def change
    add_column :kids, :views, :integer
  end
end
