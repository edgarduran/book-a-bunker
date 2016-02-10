class User < ActiveRecord::Base
  has_secure_password
  belongs_to :store
  has_many :orders
  has_many :user_roles
  has_many :roles, through: :user_roles

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

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
