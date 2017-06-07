class ReviewsController < ApplicationController

	before_filter :authorize

	def index
		@reviews = Review.all
	end

	def create
		@product = Product.find(params[:product_id])
		@review = @product.reviews.create(review_params)
		@review.user = current_user
		if @review.save
			redirect_to @product, notice: 'Ayy your review has been created.'
		else
			render 'products/show'
		end
	end
	
	def destroy
		review = Review.find(params[:id])
		review.destroy
		redirect_to product_url(review.product), notice: 'Review has been DESTROYED.'
	end

	private

	def review_params
		params.require(:review).permit(:product_id, :description, :rating)
	end

end
