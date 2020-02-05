class ReviewsController < ApplicationController
  def new
    @shelter_id = params[:shelter_id]
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    # review = Review.create!(review_params)
    review = Review.new(review_params)
    if review.save
      redirect_to "/shelters/#{shelter.id}"
    else
      flash[:notice] = "Review not created: Required information missing."
      render :new
    end
  end

  private
    def review_params
      params.permit(:title, :rating, :content, :picture, :shelter_id)
    end
end
