class Kid < ActiveRecord::Base
  has_many :kid_location

  def full_name
    "#{self.first_name} #{self.middle_name} #{last_name}"
  end

  def method_missing(method, *args, &block)
    if method.to_s =~ /^fullname$/
      self.full_name
    else
      super
    end
  end
end
