class BusinessesController < ApplicationController
  def index 
    @categories = Category.all
  end

  def show
    @business = Business.find(params[:id])
  end
end