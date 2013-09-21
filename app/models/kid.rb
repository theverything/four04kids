class Kid < ActiveRecord::Base
  before_validation :create_full_address

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :missing_state
  validates_presence_of :image_url

  has_many :kid_location

  geocoded_by :address
  before_save :geocode

  def full_name
    "#{self.first_name} #{self.middle_name} #{last_name}"
  end

  def create_full_address
    unless self.missing_city.blank? && self.missing_state.blank? 
      self.address = "#{self.missing_city}, #{self.missing_state}"
    else
      self.address = self.missing_state
    end
  end

  def method_missing(method, *args, &block)
    if method.to_s =~ /^fullname$/
      self.full_name
    else
      super
    end
  end
end
