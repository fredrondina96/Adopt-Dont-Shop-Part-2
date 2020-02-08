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

    it "adds a song that hasn't been added yet" do
      subject = Favorite.new({'1' => 2, '2' => 3})
      subject.add_pet('3')

      expect(subject.contents).to eq({'1' => 2, '2' => 3, '3' => 1})
    end
  end

  describe "#count_of" do
    it "returns the count of all pets in the favorites list" do
      favorite = Favorite.new({})

      expect(favorite.favorite_count).to eq(0)
    end
  end
end
