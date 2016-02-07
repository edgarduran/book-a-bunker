class Location < ActiveRecord::Base
  has_many :bunkers
  before_save :generate_slug

  def generate_slug
    self.slug = city.parameterize
  end
  
end
