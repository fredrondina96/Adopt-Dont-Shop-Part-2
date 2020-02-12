class PetsController < ApplicationController

  def index
    @pets = Pet.all
  end

  def show_index
    @available_pets = Pet.where(shelter_id: params[:id])
  end

  def show
     @pet = Pet.find(params[:id])
  end

  def new
    @shelter_id = params[:shelter_id]
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    pet = Pet.new(pet_params)
    if pet.save
      redirect_to "/shelters/#{shelter.id}/pets"
    else
      flash[:error] = pet.errors.full_messages.to_sentence
      redirect_to "/shelters/#{shelter.id}/pets/new"
    end
  end

  def edit
    @pet_id = params[:id]
  end

  def update
    pet = Pet.find(params[:id])
    if pet.update(pet_params)
      redirect_to "/pets/#{params[:id]}"
    else
      flash[:error] = pet.errors.full_messages.to_sentence
      redirect_to "/pets/#{pet.id}/edit"
    end
  end

  def destroy
    pet = Pet.find(params[:id])
    if pet.adoptable?
      favorites.contents.delete(pet.id.to_s)
      Pet.destroy(params[:id])
      redirect_to "/pets"
    else
      flash[:notice] = "#{pet.name} has an approved application and cannot be deleted at this time."
      redirect_to "/pets/#{pet.id}"
    end
  end

  private
    def pet_params
      params.permit(:name, :image, :description, :age, :sex, :shelter_id)
    end
end
