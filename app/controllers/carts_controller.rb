class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart

  # GET /cart
  def show
    render json: @cart, include: { cart_items: { include: :product } }
  end

  # POST /cart/add_product
  def add_product
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i.nonzero? || 1  # Garante que a quantidade seja pelo menos 1

    item = @cart.cart_items.find_or_initialize_by(product: product)
    item.quantity ||= 0 
    item.quantity += quantity
    if item.save
      render json: item, status: :ok
    else
      render json: item.errors, status: :unprocessable_entity
    end
  end

  # POST /cart/remove_product
  def remove_product
    item = @cart.cart_items.find_by(product_id: params[:product_id])
    if item
      item.destroy
      render json: { message: 'Product removed from cart' }, status: :ok
    else
      render json: { error: 'Product not found in cart' }, status: :not_found
    end
  end

  # POST /cart/checkout
  def checkout
    @cart.cart_items.destroy_all
    render json: { message: 'Checkout complete' }, status: :ok
  end

  private

  def set_cart
    @cart = current_user.cart
  end
end