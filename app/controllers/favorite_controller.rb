class FavoriteController < ApplicationController
  def update
    pet = Pet.find(params[:pet_id])
    pet_id_str = pet.id.to_s
    session[:favorites] ||= Hash.new(0)
    session[:favorites][pet_id_str] ||= 0
    session[:favorites][pet_id_str] = session[:favorites][pet_id_str] + 1
    # binding.pry
    redirect_to "/pets/#{params[:pet_id]}"
    flash[:notice] = "#{pet.name} has been added to your favorites"
  end
end
