class Store < ActiveRecord::Base
  belongs_to :location
  has_many :users
  has_many :bunkers
  has_many :orders
  before_save :generate_slug

  def generate_slug
    self.slug = name.parameterize
  end
end
