class Product < ApplicationRecord
  searchkick callbacks: false  #Testing yet
  belongs_to :user
  has_many :comments, dependent: :destroy

  validate :user_must_be_admin, on: :create

  private

  def user_must_be_admin
    errors.add(:user, 'não é um administrador') unless user&.admin?
  end
end