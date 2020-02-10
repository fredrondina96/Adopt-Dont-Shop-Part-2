class ApplicationsController < ApplicationController
  def new
    @pets = favorites.all_pets
  end

  def create
    application = Application.new(application_params)

    if application.save
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

  private
    def application_params
      params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
    end
end
