class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def add_product(product_id:, quantity: 1)
    item = cart_items.find_or_initialize_by(product_id: product_id)
    item.quantity ||= 0  # Inicializa a quantidade em 0 se for nil
    item.quantity += quantity.to_i
    item.save
  end
end
