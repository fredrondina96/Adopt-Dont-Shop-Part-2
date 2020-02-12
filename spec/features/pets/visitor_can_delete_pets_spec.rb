require 'rails_helper'

RSpec.describe "A visitor can delte a pet" do
  it "deteles pet" do
    shelter1 = Shelter.create!(name: 'humane society', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")
    shelter2 = Shelter.create!(name: 'dogs love dinosaurs', address: "5678 st", city: 'Seattle', state: 'Washington', zip: "64325")

    snickers = Pet.create!(image: 'https://images-na.ssl-images-amazon.com/images/I/41Q-6cQEOLL._AC_SY400_.jpg', name: 'Snickers', age: 15, sex: 'Female', shelter: shelter1)
    sadie = Pet.create!(image: 'https://images.halloweencostumes.com/products/45834/1-1/dog-dino-pup-costume.jpg', name: 'Sadie', age: 3, sex: "Male", shelter: shelter2)

    visit "/pets/#{snickers.id}"

    expect(page).to have_link("Delete Pet")

    click_link("Delete Pet")

    expect(current_path).to eq("/pets")

    expect(page).to have_no_content("Snickers")
    expect(page).to have_no_content("15")
    expect(page).to have_no_content("Female")
    expect(page).to have_no_content("#{shelter1.name}")
    expect(page).to have_content("Sadie")
    expect(page).to have_content("3")
    expect(page).to have_content("Male")
    expect(page).to have_content("#{shelter2.name}")

  end

  it "can't delete a pet if there is an approved application" do

    shelter1 = Shelter.create!(name: 'humane society', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")

    snickers = Pet.create!(image: 'https://images-na.ssl-images-amazon.com/images/I/41Q-6cQEOLL._AC_SY400_.jpg', name: 'Snickers', age: 15, sex: 'Female', shelter: shelter1)

    application1 = Application.create!(name: 'Chelsea', address: 'something st', city: "Denver", state: "CO", zip: "39403", phone_number: "5739495835", description: "because", status: "Approved")

    application1.pets << snickers

    visit "/pets/#{snickers.id}"

    click_link("Delete Pet")
# If a pet has an approved application on them
# I can not delete that pet
# Either:
#
# there is no button visible for me to delete the pet
# if I click on the delete button, I see a flash message indicating that the pet can not be deleted.
  end
end
