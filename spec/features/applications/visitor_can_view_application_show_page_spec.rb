require 'rails_helper'

RSpec.describe "Visitor can view individual applications on their show page" do
  it "applications have show pages" do
    shelter1 = Shelter.create!(name: 'humane society', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")

    snickers = Pet.create!(image: 'https://images-na.ssl-images-amazon.com/images/I/41Q-6cQEOLL._AC_SY400_.jpg', name: 'Snickers', age: 15, sex: 'Female', shelter: shelter1)
    sadie = Pet.create!(image: 'https://images.halloweencostumes.com/products/45834/1-1/dog-dino-pup-costume.jpg', name: 'Sadie', age: 3, sex: "Male", shelter: shelter1)

    application = Application.create!(name: 'Chelsea', address: 'something st', city: "Denver", state: "CO", zip: "39403", phone_number: "5739495835", description: "because")

    application.pets << snickers
    application.pets << sadie

    visit "/applications/#{application.id}"

    expect(page).to have_content("Chelsea")
    expect(page).to have_content("something st")
    expect(page).to have_content("Denver")
    expect(page).to have_content("CO")
    expect(page).to have_content("39403")
    expect(page).to have_content("5739495835")
    expect(page).to have_content("because")
    expect(page).to have_link("Snickers")
    expect(page).to have_link("Sadie")
  end

  it "has a link between the pet show page and any applications for that pet" do
    shelter1 = Shelter.create!(name: 'humane society', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")

    snickers = Pet.create!(image: 'https://images-na.ssl-images-amazon.com/images/I/41Q-6cQEOLL._AC_SY400_.jpg', name: 'Snickers', age: 15, sex: 'Female', shelter: shelter1)
    sadie = Pet.create!(image: 'https://images.halloweencostumes.com/products/45834/1-1/dog-dino-pup-costume.jpg', name: 'Sadie', age: 3, sex: "Male", shelter: shelter1)

    application1 = Application.create!(name: 'Chelsea', address: 'something st', city: "Denver", state: "CO", zip: "39403", phone_number: "5739495835", description: "because")
    application2 = Application.create!(name: 'Cassie', address: 'nothing st', city: "San Diego", state: "CA", zip: "35324", phone_number: "7777777777", description: "I love dogs")

    application1.pets << snickers
    applicantion2.pets << snickers
    application1.pets << sadie

    visit "/pets/#{snickers.id}"

    expect(page).to have_link("View All Applications")

    click_link("View All Applications")

    expect(current_path).to eq("/pets/#{snickers.id}/applications")

    expect(page).to have_link("Chelsea")
    expect(page).to have_link("Cassie")

    click_link("Chelsea")

    expect(current_path).to eq("applications/#{chelsea.id}")
  end
end
