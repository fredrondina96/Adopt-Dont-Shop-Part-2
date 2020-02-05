class ReviewsController < ApplicationController
<<<<<<< HEAD
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
=======
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
>>>>>>> 99783656e54bb42f5bdcb055dd8d404642558d1f
    redirect_to "/shelters/#{review.shelter_id}"
  end

  private
<<<<<<< HEAD

    def review_params
      params.permit(:title, :rating, :content, :picture)
=======
    def review_params
      params.permit(:title, :rating, :content, :picture, :shelter_id)
>>>>>>> 99783656e54bb42f5bdcb055dd8d404642558d1f
    end
end
