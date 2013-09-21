class KidLocation < ActiveRecord::Base
  belongs_to :kid
  validates_presence_of :address

  geocoded_by :address
  after_validation :geocode
end
