class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  has_secure_password

  has_many :products, dependent: :destroy
  has_one :cart, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  validates :email, presence: true, uniqueness: true

  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  def admin?
    admin  
  end 

  def cart
    super || create_cart
  end

  private

  def create_cart
    Cart.create(user: self)
  end
end