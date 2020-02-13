require 'rails_helper'

RSpec.describe Shelter, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
  end

  describe "relationships" do
    it {should have_many :pets}
    it {should have_many :reviews}
  end

  describe "#average_review_rating" do
    it " returns the average review rating for a shelter" do
      shelter1 = Shelter.create!(name: 'humane society', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")

      review1 = Review.create!(title: "Best Shelter EVER!", rating: "5", content: "I now have my best friend because of this place", shelter_id: shelter1.id)
      review2 = Review.create!(title: "Above Average Shelter", rating: "4", content: "I am pretty sure they gave me a dinosaur not a dog.", picture: "https://s7d2.scene7.com/is/image/PetSmart/5290431", shelter_id: shelter1.id)

      expect(shelter1.average_review_rating).to eq(4.5)
    end
  end

  describe "#total_applications" do
    it "gives the total number of applications for a shelter" do
      shelter1 = Shelter.create!(name: 'humane society', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")

      snickers = Pet.create!(image: 'https://images-na.ssl-images-amazon.com/images/I/41Q-6cQEOLL._AC_SY400_.jpg', name: 'Snickers', age: 15, sex: 'Female', shelter: shelter1)
      sadie = Pet.create!(image: 'https://images.halloweencostumes.com/products/45834/1-1/dog-dino-pup-costume.jpg', name: 'Sadie', age: 3, sex: "Male", shelter: shelter1)

      application1 = Application.create!(name: 'Chelsea', address: 'something st', city: "Denver", state: "CO", zip: "39403", phone_number: "5739495835", description: "because")

      application1.pets << snickers
      application1.pets << sadie

      expect(shelter1.total_applications).to eq(1)
    end
  end
end
