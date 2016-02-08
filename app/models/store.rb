class Store < ActiveRecord::Base
  has_many :users
  belongs_to :location
  has_many :bunkers
  before_save :generate_slug

  def generate_slug
    self.slug = name.parameterize
  end
end
