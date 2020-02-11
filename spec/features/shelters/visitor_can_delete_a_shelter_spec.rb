require 'rails_helper'

RSpec.describe "A shelter can be delted", type: :feature do
  it "deletes a shelter" do
    shelter1 = Shelter.create!(name: 'humane society', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")

    visit "/shelters/#{shelter1.id}"

    expect(page).to have_link("Delete Shelter")

    click_link("Delete Shelter")

    expect(current_path).to eq("/shelters")

    expect(page).to have_no_content('humane society')
  end

  it "can only delete a shelter if there are no approved applications" do

    shelter1 = Shelter.create!(name: 'humane society', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")

    snickers = Pet.create!(image: 'https://images-na.ssl-images-amazon.com/images/I/41Q-6cQEOLL._AC_SY400_.jpg', name: 'Snickers', age: 15, sex: 'Female', shelter: shelter1, adoption_status: "Pending")
    sadie = Pet.create!(image: 'https://images.halloweencostumes.com/products/45834/1-1/dog-dino-pup-costume.jpg', name: 'Sadie', age: 3, sex: "Male", shelter: shelter1, adoption_status: "Pending")

    application1 = Application.create!(name: 'Chelsea', address: 'something st', city: "Denver", state: "CO", zip: "39403", phone_number: "5739495835", description: "because", status: "approved")

    application1.pets << snickers
    application1.pets << sadie

    visit "/shelters/#{shelter1.id}"

    expect(page).to have_link("Delete Shelter")

    click_link("Delete Shelter")

    expect(page).to have_content("#{shelter1.name} has approved applications and cannot be deleted at this time.")
  end
end
