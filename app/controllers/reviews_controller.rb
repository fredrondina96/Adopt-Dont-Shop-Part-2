class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
    # binding.pry
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    review = Review.find(params[:id])
    # binding.pry
    review.update(review_params)
    # binding.pry
    redirect_to "/shelters/#{review.shelter_id}"
  end

  private

    def review_params
      params.permit(:title, :rating, :content, :picture)
    end
end
