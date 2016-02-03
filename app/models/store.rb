class Store < ActiveRecord::Base
  belongs_to :user
  belongs_to :location
  has_many :bunkers
  before_save :generate_slug

  def generate_slug
    self.slug = name.parameterize 
  end
end
