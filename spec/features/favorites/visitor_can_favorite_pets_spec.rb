require "rails_helper"

RSpec.describe "Visitor can favorite and view their favorites" do
  it "sees total of favorited pets at the top of every page" do

    visit "/pets"

    expect(page).to have_content("Favorites: 0")

    visit "/shelters"

    expect(page).to have_content("Favorites: 0")
  end

  it "Can add pets to favorite list" do
    shelter1 = Shelter.create!(name: 'humane society', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")
    snickers = Pet.create!(image: 'https://images-na.ssl-images-amazon.com/images/I/41Q-6cQEOLL._AC_SY400_.jpg', name: 'Snickers', age: 15, sex: 'Female', shelter: shelter1)

    visit "/pets/#{snickers.id}"

    expect(page).to have_link("Favorite")

    expect(page).to have_content("Favorites: 0")

    click_link("Favorite")

    expect(current_path).to eq("/pets/#{snickers.id}")

    expect(page).to have_content("Favorites: 1")
    expect(page).to have_content("#{snickers.name} has been added to your favorites")
  end

  it "can show all of the favorited pets at /favorites" do
    shelter1 = Shelter.create!(name: 'humane society', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")
    snickers = Pet.create!(image: 'https://images-na.ssl-images-amazon.com/images/I/41Q-6cQEOLL._AC_SY400_.jpg', name: 'Snickers', age: 15, sex: 'Female', shelter: shelter1)
    snoop = Pet.create!(image: 'https://www.pinclipart.com/picdir/big/2-21285_clip-art-snoopy-snoop-dogg-charlie-brown-png.png', name: 'Snoop', age: 9, sex: 'Male', shelter: shelter1)
    visit "/pets/#{snoop.id}"
    click_link("Favorite")
    expect(current_path).to eq("/pets/#{snoop.id}")
    visit "/favorites"
    expect(page).to have_content("Snoop")
    click_link("Snoop")
    expect(current_path).to eq("/pets/#{snoop.id}")
  end
end
