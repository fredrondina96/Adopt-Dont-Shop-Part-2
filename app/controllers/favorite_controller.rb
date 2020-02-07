class FavoriteController < ApplicationController
  include ActionView::Helpers::TextHelper
  def update
    pet = Pet.find(params[:pet_id])
    pet_id_str = pet.id.to_s
    favorites.add_pet(pet.id)
    session[:favorites] = favorites.contents
    # quantity = favorites.count_of(pet.id)
    # flash[:notice] = "You now have #{pluralize(quantity, "copy")} of #{} in your cart."
    # session[:favorites][pet_id_str] ||= 0
    # session[:favorites][pet_id_str] = session[:favorites][pet_id_str] + 1
    # binding.pry
    redirect_to "/pets/#{params[:pet_id]}"
    flash[:notice] = "#{pet.name} has been added to your favorites"
  end
end
