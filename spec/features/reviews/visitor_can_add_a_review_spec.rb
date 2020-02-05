require 'rails_helper'

RSpec.describe "Visitor can add a shelter review from the shelter show page" do
  it "adds a review of a shelter" do
    shelter1 = Shelter.create!(name: 'humane society', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")

    review1 = Review.create!(title: "Best Shelter EVER!", rating: "5", content: "I now have my best friend because of this place", shelter_id: shelter1.id)
    review2 = Review.create!(title: "Above Average Shelter", rating: "4", content: "I am pretty sure they gave me a dinosaur not a dog.", picture: "https://s7d2.scene7.com/is/image/PetSmart/5290431", shelter_id: shelter1.id)

    visit "shelters/#{shelter1.id}"

    expect(page).to have_link("New Review")

    click_link("New Review")

    expect(current_path).to eq("/shelters/#{shelter1.id}/reviews/new")

    fill_in "title", with: "Lovely Shelter"
    fill_in "rating", with: "3"
    fill_in "content", with: "Really a very lovely facilitiy. Not sure what kind of dogs these are though"
    fill_in "picture", with: "https://i.ytimg.com/vi/PJlmYh27MHg/maxresdefault.jpg"

    expect(page).to have_button("Submit")

    click_on("Submit")

    expect(current_path).to eq("/shelters/#{shelter1.id}")

    expect(page).to have_content("Lovely Shelter")
    expect(page).to have_content("3")
    expect(page).to have_content("Really a very lovely facilitiy. Not sure what kind of dogs these are though")
  end

  it "returns a flash notice if the user doesn't give enough information" do
    shelter1 = Shelter.create!(name: 'humane society', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")

    review1 = Review.create!(title: "Best Shelter EVER!", rating: "5", content: "I now have my best friend because of this place", shelter_id: shelter1.id)
    review2 = Review.create!(title: "Above Average Shelter", rating: "4", content: "I am pretty sure they gave me a dinosaur not a dog.", picture: "https://s7d2.scene7.com/is/image/PetSmart/5290431", shelter_id: shelter1.id)

    visit "/shelters/#{shelter1.id}/reviews/new"

    fill_in "rating", with: "3"
    fill_in "content", with: "Really a very lovely facilitiy. Not sure what kind of dogs these are though"

    click_on("Submit")

    expect(page).to have_content("Review not created: Required information missing.")
    expect(page).to have_button('Submit')
  end
end
