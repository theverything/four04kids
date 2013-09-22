class KidSerializer < ActiveModel::Serializer
  cached

  attributes :id, :missing_city, :missing_state, :missing_county, :missing_country, :missing_date,
    :age, :thumbnail_url, :image_url, :aged_photo_url, :case_number,
    :org_prefix, :first_name, :last_name, :middle_name, :age, :full_name

    def cache_key
      [object, object.updated_at]
    end
end
