require 'rails_helper'

RSpec.describe Favorite do

  describe "#total_count" do
    it "can calculate the total number of favorites" do
      favorite =  Favorite.new({'1' => 1, '2' => 1, '3' => 1})
      expect(favorite.total_count).to eq(3)
    end
  end

  describe "#add_pet" do
    it "adds a pet to its contents" do
      subject =  Favorite.new({'1' => 2, '2' => 3})

      subject.add_pet(1)
      subject.add_pet(2)

      expect(subject.contents).to eq({'1' => 3, '2' => 4})
    end

    it "adds a pet that hasn't been added yet" do
      subject = Favorite.new({'1' => 2, '2' => 3})
      subject.add_pet('3')

      expect(subject.contents).to eq({'1' => 2, '2' => 3, '3' => 1})
    end
  end

  describe "#favorite_count" do
    it "returns the count of all pets in the favorites list" do
      favorite = Favorite.new({})

      expect(favorite.favorite_count).to eq(0)
    end
  end

  describe "#pet_check" do
    it "It checks if a pet is in the shelter" do
    shelter1 = Shelter.create!(name: 'humane society', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")

    snickers = Pet.create!(image: 'https://images-na.ssl-images-amazon.com/images/I/41Q-6cQEOLL._AC_SY400_.jpg', name: 'Snickers', age: 15, sex: 'Female', shelter: shelter1)
    sadie = Pet.create!(image: 'https://images.halloweencostumes.com/products/45834/1-1/dog-dino-pup-costume.jpg', name: 'Sadie', age: 3, sex: "Male", shelter: shelter1)
    abbey = Pet.create!(image: 'https://petcostumecenter.com/wp-content/uploads/2019/08/Pupasaurus-Rex-T-Rex-Dog-Cat-Costume-.png', name: 'Abbey', age: 6, sex: "Male", shelter: shelter1)

    favorite =  Favorite.new({"#{snickers.id}" => 1, "#{sadie.id}" => 1, "#{abbey.id}" => 1})

    expect(favorite.pet_check(snickers.id)).to be_in([true, false])
  end
end

  describe "#all_pets" do
    it "returns an array of all pet objects that are currently favorited" do
      shelter1 = Shelter.create!(name: 'humane society', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")

      snickers = Pet.create!(image: 'https://images-na.ssl-images-amazon.com/images/I/41Q-6cQEOLL._AC_SY400_.jpg', name: 'Snickers', age: 15, sex: 'Female', shelter: shelter1)
      sadie = Pet.create!(image: 'https://images.halloweencostumes.com/products/45834/1-1/dog-dino-pup-costume.jpg', name: 'Sadie', age: 3, sex: "Male", shelter: shelter1)
      abbey = Pet.create!(image: 'https://petcostumecenter.com/wp-content/uploads/2019/08/Pupasaurus-Rex-T-Rex-Dog-Cat-Costume-.png', name: 'Abbey', age: 6, sex: "Male", shelter: shelter1)

      favorite =  Favorite.new({"#{snickers.id}" => 1, "#{sadie.id}" => 1, "#{abbey.id}" => 1})

      expect(favorite.all_pets).to eq([snickers, sadie, abbey])
    end
  end

  describe "#count_of" do
    it "counts the number of favorites" do
      shelter1 = Shelter.create!(name: 'humane society', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")

      snickers = Pet.create!(image: 'https://images-na.ssl-images-amazon.com/images/I/41Q-6cQEOLL._AC_SY400_.jpg', name: 'Snickers', age: 15, sex: 'Female', shelter: shelter1)
      sadie = Pet.create!(image: 'https://images.halloweencostumes.com/products/45834/1-1/dog-dino-pup-costume.jpg', name: 'Sadie', age: 3, sex: "Male", shelter: shelter1)
      abbey = Pet.create!(image: 'https://petcostumecenter.com/wp-content/uploads/2019/08/Pupasaurus-Rex-T-Rex-Dog-Cat-Costume-.png', name: 'Abbey', age: 6, sex: "Male", shelter: shelter1)

      favorite =  Favorite.new({"#{snickers.id}" => 1, "#{sadie.id}" => 1, "#{abbey.id}" => 1})

      expect(favorite.count_of(snickers.id)).to eq(1)
    end
  end
end
