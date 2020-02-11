class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def new
    @shelter_id = params[:id]
  end

  def create
    shelter = Shelter.create!(shelter_params)
    redirect_to '/shelters'
  end

  def edit
    @shelter_id = params[:id]
  end

  def update
    shelter =  Shelter.find(params[:id])
    shelter.update(shelter_params)
    redirect_to "/shelters/#{shelter.id}"
  end

  def destroy
    shelter = Shelter.find(params[:id])
    if approved_application?
      flash[:notice] = "#{shelter.name} has approved applications and cannot be deleted at this time."
      redirect_to "/shelters/#{shelter.id}"
    else
      Shelter.destroy(params[:id])
      redirect_to "/shelters"
    end
  end

  private
  def shelter_params
    params.permit(:name, :address, :city, :zip, :state)
  end

  def approved_application?
    shelter = Shelter.find(params[:id])

    answer = false

    shelter.pets.each do |pet|
     answer = pet.applications.any? do |application|
        application.status == "approved"
      end
    end
    answer
  end
end
