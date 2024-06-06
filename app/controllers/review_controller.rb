# app/controllers/review_controller.rb
class ReviewController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: [:actualizar_review, :eliminar]

  def show
    @review = Review.find(params[:id])
  end

  def insertar
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new(review_params)
    @review.user = current_user

    if @review.save
      redirect_to "/products/leer/#{@product.id}", notice: 'Review created successfully.'
    else
      flash[:error] = 'Failed to create review.'
      redirect_to "/products/leer/#{@product.id}"
    end
  end

  def actualizar_review
    if @review.update(review_params)
      redirect_to "/products/leer/#{@review.product_id}", notice: 'Review updated successfully.'
    else
      flash[:error] = 'Failed to update review.'
      redirect_to "/products/leer/#{@review.product_id}"
    end
  end

  def eliminar
    @review.destroy
    redirect_to "/products/leer/#{@review.product_id}", notice: 'Review deleted successfully.'
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:tittle, :description, :calification)
  end

  
end
