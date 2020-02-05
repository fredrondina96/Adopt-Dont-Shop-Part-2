require 'rails_helper'

RSpce.describe "A visitor can delete a review" do
  it "deletes a review" do
    shelter1 = Shelter.create!(name: 'humane society', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")

    review1 = Review.create!(title: "Best Shelter EVER!", rating: "5", content: "I now have my best friend because of this place", shelter_id: shelter1.id)
    review2 = Review.create!(title: "Above Average Shelter", rating: "4", content: "I am pretty sure they gave me a dinosaur not a dog.", picture: "https://s7d2.scene7.com/is/image/PetSmart/5290431", shelter_id: shelter1.id)

    visit "shelters/#{shelter1.id}"

    expect(page).to have_link("Delete Review", count: 2)

    click_link("Delete Review")
  end
end
