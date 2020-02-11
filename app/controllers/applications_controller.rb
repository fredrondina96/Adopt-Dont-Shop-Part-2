class ApplicationsController < ApplicationController
  def new
    @pets = favorites.all_pets
  end

  def create
    application = Application.new(application_params)

    if application.save
      application_save_success
      flash[:notice] = "You have successfully completed your application!!!"
      params[:adopt_pets].each do |pet|
        adopted_pet = Pet.find(pet)
        adopted_pet.applications << application
        favorites.contents.delete(pet)
      end

      redirect_to '/favorites'
    else
      redirect_to '/applications/new'
      flash[:notice] = "You must complete all fields on this form in order to submit your application."
    end
  end

  def show
    @application = Application.find(params[:id])
  end

  def index
    @pet = Pet.find(params[:pet_id])
  end

  def update
    application = Application.find(params[:application_id])
    application.status = "approved"
    application.save
    pet = Pet.find(params[:pet_id])
    pet.adoption_status = "Pending"
    pet.save
    redirect_to "/pets/#{pet.id}"
  end

  private
    def application_params
      params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
    end
end
