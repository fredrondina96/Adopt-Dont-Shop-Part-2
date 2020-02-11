require 'rails_helper'

RSpec.describe "Visitors can approve applications" do

  it "applications can be approved" do
    shelter1 = Shelter.create!(name: 'humane society', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")

    snickers = Pet.create!(image: 'https://images-na.ssl-images-amazon.com/images/I/41Q-6cQEOLL._AC_SY400_.jpg', name: 'Snickers', age: 15, sex: 'Female', shelter: shelter1)
    sadie = Pet.create!(image: 'https://images.halloweencostumes.com/products/45834/1-1/dog-dino-pup-costume.jpg', name: 'Sadie', age: 3, sex: "Male", shelter: shelter1)

    application1 = Application.create!(name: 'Chelsea', address: 'something st', city: "Denver", state: "CO", zip: "39403", phone_number: "5739495835", description: "because")

    application1.pets << snickers
    application1.pets << sadie

    visit "/applications/#{application1.id}"

    within("#application-#{snickers.id}") do
      expect(page).to have_link("Approve Application for Snickers")
    end

    within("#application-#{sadie.id}") do
      expect(page).to have_link("Approve Application for Sadie")
      click_link("Approve Application for Sadie")
    end

    expect(current_path).to eq("/pets/#{sadie.id}")

    expect(page).to have_content("Status: Pending")
    expect(page).to have_content("On hold for Chelsea")
  end

  it "can approve mulitple pets on an application at once" do

    shelter1 = Shelter.create!(name: 'humane society', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")

    snickers = Pet.create!(image: 'https://images-na.ssl-images-amazon.com/images/I/41Q-6cQEOLL._AC_SY400_.jpg', name: 'Snickers', age: 15, sex: 'Female', shelter: shelter1)
    sadie = Pet.create!(image: 'https://images.halloweencostumes.com/products/45834/1-1/dog-dino-pup-costume.jpg', name: 'Sadie', age: 3, sex: "Male", shelter: shelter1)

    application1 = Application.create!(name: 'Chelsea', address: 'something st', city: "Denver", state: "CO", zip: "39403", phone_number: "5739495835", description: "because")

    application1.pets << snickers
    application1.pets << sadie

    visit "/applications/#{application1.id}"

    within("#application-#{snickers.id}") do
      page.check
    end

    within("#application-#{sadie.id}") do
      page.check
    end

    click_link("Approve All Selected Pets")

    visit "/pets/#{sadie.id}"

    expect(page).to have_content("Status: Pending")
    expect(page).to have_content("On hold for Chelsea")

    visit "/pets/#{snickers.id}"

    expect(page).to have_content("Status: Pending")
    expect(page).to have_content("On hold for Chelsea")


# I'm able to approve the application for any number of pets
  end
end
