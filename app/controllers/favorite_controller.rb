class FavoriteController < ApplicationController
  include ActionView::Helpers::TextHelper
  def update
    pet = Pet.find(params[:pet_id])
    pet_id_str = pet.id.to_s
    favorites.add_pet(pet.id)
    session[:favorites] = favorites.contents
    redirect_to "/pets/#{params[:pet_id]}"
    flash[:notice] = "#{pet.name} has been added to your favorites"
  end

  def index
    @applications = Application.all
  end

  def destroy
    favorites.contents.delete(params[:pet_id])
    # binding.pry
    redirect_to "/pets/#{params[:pet_id]}"
    flash[:notice] = "Pet removed from favorites"
  end

  def remove_favorite
    # binding.pry
    favorites.contents.delete(params[:id])
    # binding.pry
    redirect_to "/favorites"
    flash[:notice] = "Pet removed from favorites"
  end

  def edit
    favorites.contents.delete(params[:pet_id])
    redirect_to "/favorites"
    flash[:notice] = "Pet removed from favorites"
  end
end
