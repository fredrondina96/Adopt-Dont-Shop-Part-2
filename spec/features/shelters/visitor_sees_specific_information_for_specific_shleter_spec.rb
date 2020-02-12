require "rails_helper"

RSpec.describe "Shelter ID displays all shelter info", type: :feature do
  it "shows all info for specific shelter" do
    shelter1 = Shelter.create(name: 'humane society', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")
    shelter2 = Shelter.create(name: "Pound", address: "5678 st", city: 'Seattle', state: 'Washington', zip: "390507")
    shleter3 = Shelter.create(name: "Old Dogs Home", address: '2948 st', city: 'San Diego', state: 'California', zip: "30958")

    visit "/shelters/#{shelter1.id}"

    expect(page).to have_content(shelter1.name)
    expect(page).to have_content(shelter1.address)
    expect(page).to have_content(shelter1.city)
    expect(page).to have_content(shelter1.state)
    expect(page).to have_content(shelter1.zip)

    visit "/shelters/#{shelter2.id}"

    expect(page).to have_content(shelter2.name)
    expect(page).to have_content(shelter2.address)
    expect(page).to have_content(shelter2.city)
    expect(page).to have_content(shelter2.state)
    expect(page).to have_content(shelter2.zip)

    visit "/shelters/#{shleter3.id}"

    expect(page).to have_content(shleter3.name)
    expect(page).to have_content(shleter3.address)
    expect(page).to have_content(shleter3.city)
    expect(page).to have_content(shleter3.state)
    expect(page).to have_content(shleter3.zip)
  end

  it "shows statistics for each shelter on its show page" do
    shelter1 = Shelter.create!(name: 'humane society', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")

    review1 = Review.create!(title: "Best Shelter EVER!", rating: "5", content: "I now have my best friend because of this place", shelter_id: shelter1.id)
    review2 = Review.create!(title: "Above Average Shelter", rating: "4", content: "I am pretty sure they gave me a dinosaur not a dog.", picture: "https://s7d2.scene7.com/is/image/PetSmart/5290431", shelter_id: shelter1.id)

    snickers = Pet.create!(image: 'https://images-na.ssl-images-amazon.com/images/I/41Q-6cQEOLL._AC_SY400_.jpg', name: 'Snickers', age: 15, sex: 'Female', shelter: shelter1)
    sadie = Pet.create!(image: 'https://images.halloweencostumes.com/products/45834/1-1/dog-dino-pup-costume.jpg', name: 'Sadie', age: 3, sex: "Male", shelter: shelter1)
    abbey = Pet.create!(image: 'https://petcostumecenter.com/wp-content/uploads/2019/08/Pupasaurus-Rex-T-Rex-Dog-Cat-Costume-.png', name: 'Abbey', age: 6, sex: "Male", shelter: shelter1)

    application1 = Application.create!(name: 'Chelsea', address: 'something st', city: "Denver", state: "CO", zip: "39403", phone_number: "5739495835", description: "because")
    application2 = Application.create!(name: 'Cassie', address: 'nothing st', city: "Seattle", state: "WA", zip: "39402", phone_number: "7777777777", description: "I love dogs")

    application1.pets << snickers
    application1.pets << sadie
    application2.pets << abbey

    visit "/shelters/#{shelter1.id}"

    expect(page).to have_content("Total Pets: 3")
    expect(page).to have_content("Average Review Rating: 4.5")
    expect(page).to have_content("Total Applications: 2")
  end
end
