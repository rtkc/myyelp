class ReviewsController < ApplicationController
before_action :require_sign_in

  def index
    @reviews = Review.order('created_at DESC')
  end

  def create
    @business = Business.find(params[:business_id])
    @review = @business.reviews.build(review_params)
    @review.creator = current_user

    if @review.save
      flash[:success] = "Your review was created successfully."
      redirect_to business_path(@business)
    else
      @reviews = @business.reviews.reload
      render 'businesses/show'
    end
  end

  private
  def review_params
    params.require(:review).permit(:rating, :review)
  end
end