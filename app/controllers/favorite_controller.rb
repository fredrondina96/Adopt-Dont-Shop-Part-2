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

  end
end
