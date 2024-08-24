class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :set_product

  # GET /products/:product_id/comments
  def index
    @comments = @product.comments
    render json: @comments
  end

  # POST /products/:product_id/comments
  def create
    @comment = @product.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end