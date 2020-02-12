require "rails_helper"

RSpec.describe "A visitor can click on any instance of an applications name and be brought to its show page" do
  it "pets show page" do
    shelter1 = Shelter.create!(name: 'humane society', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")

    snickers = Pet.create!(image: 'https://images-na.ssl-images-amazon.com/images/I/41Q-6cQEOLL._AC_SY400_.jpg', name: 'Snickers', age: 15, sex: 'Female', shelter: shelter1)

    application = Application.create!(name: 'Chelsea', address: 'something st', city: "Denver", state: "CO", zip: "39403", phone_number: "5739495835", description: "because")

    application.pets << snickers

    visit "/applications/#{application.id}"

    within("#application-#{snickers.id}") do
      click_link("Approve Application for Snickers")
    end

    visit "/pets/#{snickers.id}"

    expect(page).to have_link("#{application.name}")
  end

  it "applications index page" do
    shelter1 = Shelter.create!(name: 'humane society', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")

    snickers = Pet.create!(image: 'https://images-na.ssl-images-amazon.com/images/I/41Q-6cQEOLL._AC_SY400_.jpg', name: 'Snickers', age: 15, sex: 'Female', shelter: shelter1)

    application = Application.create!(name: 'Chelsea', address: 'something st', city: "Denver", state: "CO", zip: "39403", phone_number: "5739495835", description: "because")

    application.pets << snickers

    visit "/pets/#{snickers.id}/applications"

    expect(page).to have_link("#{application.name}")
  end
end
