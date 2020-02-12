require 'rails_helper'

RSpec.describe "A visitor can click on a pets name anywhere on the site and be brought to the pets show page" do
  it "Pets index page" do
    shelter1 = Shelter.create!(name: 'humane society', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")

    snickers = Pet.create!(image: 'https://images-na.ssl-images-amazon.com/images/I/41Q-6cQEOLL._AC_SY400_.jpg', name: 'Snickers', age: 15, sex: 'Female', shelter: shelter1)

    visit "/pets"

    expect(page).to have_link("#{snickers.name}")

    click_link("#{snickers.name}")

    expect(current_path).to eq("/pets/#{snickers.id}")
  end

  it "shelter pets show page" do
    shelter1 = Shelter.create!(name: 'humane society', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")

    snickers = Pet.create!(image: 'https://images-na.ssl-images-amazon.com/images/I/41Q-6cQEOLL._AC_SY400_.jpg', name: 'Snickers', age: 15, sex: 'Female', shelter: shelter1)

    visit "/shelters/#{shelter1.id}/pets"

    expect(page).to have_link("#{snickers.name}")

    click_link("#{snickers.name}")

    expect(current_path).to eq("/pets/#{snickers.id}")
  end

  it "Applications show page" do
    shelter1 = Shelter.create!(name: 'humane society', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")

    snickers = Pet.create!(image: 'https://images-na.ssl-images-amazon.com/images/I/41Q-6cQEOLL._AC_SY400_.jpg', name: 'Snickers', age: 15, sex: 'Female', shelter: shelter1)

    application1 = Application.create!(name: 'Chelsea', address: 'something st', city: "Denver", state: "CO", zip: "39403", phone_number: "5739495835", description: "because")

    application1.pets << snickers

    visit "/applications/#{application1.id}"

    expect(page).to have_link("Snickers")

    within "#application-#{snickers.id}" do
      click_link("#{snickers.name}")
    end

    expect(current_path).to eq("/pets/#{snickers.id}")
  end

  it "Favorites index page" do
    shelter1 = Shelter.create!(name: 'humane society', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")

    snickers = Pet.create!(image: 'https://images-na.ssl-images-amazon.com/images/I/41Q-6cQEOLL._AC_SY400_.jpg', name: 'Snickers', age: 15, sex: 'Female', shelter: shelter1)

    application1 = Application.create!(name: 'Chelsea', address: 'something st', city: "Denver", state: "CO", zip: "39403", phone_number: "5739495835", description: "because")

    application1.pets << snickers

    visit "/pets/#{snickers.id}"

    click_link("Favorite Pet")

    visit "/favorites"

    expect(page).to have_link("Snickers")

    within "#application-#{snickers.id}" do
      click_link("#{snickers.name}")
    end

    expect(current_path).to eq("/pets/#{snickers.id}")
  end
end
