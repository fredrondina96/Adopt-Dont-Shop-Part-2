require 'rails_helper'

RSpec.describe "Visitor can see a list of all reviews for a shelter from the shelter show page" do
  it "shows a list of all reviews for a shelter" do
    shelter1 = Shelter.create!(name: 'humane society', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")

    review1 = Review.create!(title: "Best Shelter EVER!", rating: "5", content: "I now have my best friend because of this place", shelter_id: shelter1.id)
    review2 = Review.create!(title: "Above Average Shelter", rating: "4", content: "I am pretty sure they gave me a dinosaur not a dog.", picture: "https://s7d2.scene7.com/is/image/PetSmart/5290431", shelter_id: shelter1.id)

    visit "shelters/#{shelter1.id}"

    expect(page).to have_content("Best Shelter EVER!")
    expect(page).to have_content("5")
    expect(page).to have_content("I now have my best friend because of this place")
    expect(page).to have_content("Above Average Shelter")
    expect(page).to have_content("4")
    expect(page).to have_content("I am pretty sure they gave me a dinosaur not a dog.")
  end
end
