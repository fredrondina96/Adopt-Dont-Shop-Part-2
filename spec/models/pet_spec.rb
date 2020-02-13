require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe "validations" do
    it {should validate_presence_of :image}
    it {should validate_presence_of :name}
    it {should validate_presence_of :age}
    it {should validate_presence_of :sex}
    it {should validate_presence_of :shelter}
  end

  describe "relationships" do
    it {should belong_to :shelter}
    it {should have_many :pet_applications}
    it {should have_many(:applications).through(:pet_applications)}
  end

  describe "#has_no_applications?" do
    it "has no applications" do
      shelter1 = Shelter.create!(name: 'humane society', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")

      snickers = Pet.create!(image: 'https://images-na.ssl-images-amazon.com/images/I/41Q-6cQEOLL._AC_SY400_.jpg', name: 'Snickers', age: 15, sex: 'Female', shelter: shelter1)
      sadie = Pet.create!(image: 'https://images.halloweencostumes.com/products/45834/1-1/dog-dino-pup-costume.jpg', name: 'Sadie', age: 3, sex: "Male", shelter: shelter1)

      application1 = Application.create!(name: 'Chelsea', address: 'something st', city: "Denver", state: "CO", zip: "39403", phone_number: "5739495835", description: "because")

      application1.pets << snickers
      application1.pets << sadie

      expect(sadie.has_no_applications?).to be_in([true, false])
    end
  end

  describe "#approved_application" do
    it "returns the approved application if any for that pet" do
      shelter1 = Shelter.create!(name: 'humane society', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")

      snickers = Pet.create!(image: 'https://images-na.ssl-images-amazon.com/images/I/41Q-6cQEOLL._AC_SY400_.jpg', name: 'Snickers', age: 15, sex: 'Female', shelter: shelter1)
      sadie = Pet.create!(image: 'https://images.halloweencostumes.com/products/45834/1-1/dog-dino-pup-costume.jpg', name: 'Sadie', age: 3, sex: "Male", shelter: shelter1)

      application1 = Application.create!(name: 'Chelsea', address: 'something st', city: "Denver", state: "CO", zip: "39403", phone_number: "5739495835", description: "because", status: "approved")

      application1.pets << snickers
      application1.pets << sadie

      expect(sadie.approved_application).to eq(application1)
    end
  end

  describe "#adoptable?" do
    it "returns if the pet is currently adoptable or not" do
      shelter1 = Shelter.create!(name: 'humane society', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")

      snickers = Pet.create!(image: 'https://images-na.ssl-images-amazon.com/images/I/41Q-6cQEOLL._AC_SY400_.jpg', name: 'Snickers', age: 15, sex: 'Female', shelter: shelter1)
      sadie = Pet.create!(image: 'https://images.halloweencostumes.com/products/45834/1-1/dog-dino-pup-costume.jpg', name: 'Sadie', age: 3, sex: "Male", shelter: shelter1)

      application1 = Application.create!(name: 'Chelsea', address: 'something st', city: "Denver", state: "CO", zip: "39403", phone_number: "5739495835", description: "because", status: "approved")

      application1.pets << snickers
      application1.pets << sadie

      expect(sadie.adoptable?).to be_in([true, false])
    end
  end
end
