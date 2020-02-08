class ApplyController < ApplicationController
  def new
    @pets = []
    favorites.contents.each do |pet_id, amount|
      @pets << Pet.find(pet_id)
    end
  end

  def create
    params[:adopt_pets].each do |pet|
      favorites.contents.delete(pet)
    end
    flash[:notice] = "You have successfully completed your application!!!"
    redirect_to '/favorites'
  end
end
