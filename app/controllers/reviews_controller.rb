class ReviewsController < ApplicationController
  before_filter :ensure_logged_in, :only => [:new, :edit, :create, :update, :destroy]
  before_filter :load_product

  def show
    @review = Review.find(params[:id])
  end

  def create
    # @review = Review.new(
    #   :comment    => params[:review][:comment], 
    #   :product_id => @product.id, 
    #   :user_id    => current_user.id
    # )
    @review = @product.reviews.build(
      :comment => params[:review][:comment],
      :user_id => current_user.id
    )

    if @review.save
      redirect_to @product, notice: 'Review was successfully created.'
    else
      # render action: "../products/show" # Hacky, not nice
      render "products/show"
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])

    if @review.update_attributes(params[:review])
      redirect_to product_review_path, notice: 'Review was successfully updated.'
    else
      render action: "edit"
    end
  end

  private

  def load_product
    @product = Product.find(params[:product_id])
  end
end
