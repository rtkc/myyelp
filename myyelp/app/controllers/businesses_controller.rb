class BusinessesController < ApplicationController
  before_action :require_sign_in
  
  def new
    @business = Business.new
  end

  def create
    @business = Business.new(business_params)

    if @business.save
      flash[:success] = "You've successfully added a business to the directory. Thanks!"
      redirect_to business_path(@business)
    else 
      render :new
    end
  end

  def index 
    @categories = Category.all
  end

  def show
    @business = Business.find(params[:id])
    @review = Review.new
    @reviews = @business.reviews
  end

  private
  def business_params
    params.require(:business).permit(:name, :description, :category_id)
  end
end