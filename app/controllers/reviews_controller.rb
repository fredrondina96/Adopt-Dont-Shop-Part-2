class ReviewsController < ApplicationController

  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    review = Review.find(params[:id])
    review.update(review_params)
    redirect_to "/shelters/#{review.shelter_id}"
  end

  def new
    @shelter_id = params[:shelter_id]
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    review = Review.new(review_params)
    if review.save
      redirect_to "/shelters/#{shelter.id}"
    else
      flash[:notice] = "Review not created: Required information missing."
      render :new
    end
  end

  def destroy
    review = Review.find(params[:id])
    Review.destroy(params[:id])
    redirect_to "/shelters/#{review.shelter_id}"
  end

  private

    def review_params
      params.permit(:title, :rating, :content, :picture, :shelter_id)
    end
end
