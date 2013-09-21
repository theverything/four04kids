class RequestLocation < ActiveRecord::Base
  geocode_by :ip_address
  after_validation :geocode
end
