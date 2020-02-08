require 'rails_helper'

RSpec.describe Application, type: :model do
  describe "validations" do
    it {should validate_presence_of :name, :address, :city, :state, :zip, :phone_number, :description}
  end

  describe "relationships" do
    it {should have_many :pet_applications}
    it {should have_many(:pets).through(:pet_applications)}
  end
end
