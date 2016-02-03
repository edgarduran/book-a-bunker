class User < ActiveRecord::Base
  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  scope :safe_houses, -> { where(safe_house: true) }

  has_many :orders
  has_many :user_roles
  has_many :roles, through: :user_roles

  after_validation :geocode
  geocoded_by :full_street_address

  def full_street_address
    unless address.nil? || city.nil? || state.nil? || zipcode.nil?
      address + ", " + city + ", " + state + ", " + zipcode
    end
  end

  def self.safe_houses
    where(safe_house: 1)
  end

  def platform_admin?
    roles.exists?(name: "platform_admin")
  end

  def store_admin?
    roles.exists?(name: "store_admin")
  end

  def registered_user?
    roles.exists?(name: "registered_user")
  end

end
