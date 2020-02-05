class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
    # binding.pry
  end

  def edit
    @review_id = params[:id]
  end

  def update
    binding.pry
  end
end
