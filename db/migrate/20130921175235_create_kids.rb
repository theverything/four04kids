class CreateKids < ActiveRecord::Migration
  def change
    create_table :kids do |t|
      t.string :case_number
      t.string :org_prefix
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :missing_city
      t.string :missing_state
      t.string :missing_county
      t.string :missing_state
      t.string :missing_country
      t.date :missing_date
      t.integer :age
      t.boolean :thumbnail
      t.boolean :poster
      t.string :thumbnail_url
      t.string :image_url
      t.string :aged_photo_url
      t.boolean :has_aged_photo

      t.timestamps
    end
  end
end
