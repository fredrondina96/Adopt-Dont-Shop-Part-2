require 'rails_helper'

RSpec.describe "A shelter can be deleted", type: :feature do
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

  it "Shelters can be deleted if no pets have a pending status" do
    shelter1 = Shelter.create!(name: 'humane society', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")
    shelter2 = Shelter.create!(name: 'Dogs love dinosaurs', address: "4768 st", city: 'Issaquah', state: 'WA', zip: "09868")

    snickers = Pet.create!(image: 'https://images-na.ssl-images-amazon.com/images/I/41Q-6cQEOLL._AC_SY400_.jpg', name: 'Snickers', age: 15, sex: 'Female', shelter: shelter1)
    sadie = Pet.create!(image: 'https://images.halloweencostumes.com/products/45834/1-1/dog-dino-pup-costume.jpg', name: 'Sadie', age: 3, sex: "Male", shelter: shelter1)
    abbey = Pet.create!(image: 'https://www.rover.com/blog/wp-content/uploads/2019/09/frisco-raptor-e1567812754551.jpg', name: 'Abbey', age: 6, sex: "Female", shelter: shelter2)

    application1 = Application.create!(name: 'Chelsea', address: 'something st', city: "Denver", state: "CO", zip: "39403", phone_number: "5739495835", description: "because")

    application1.pets << snickers
    application1.pets << sadie

    visit "/shelters/#{shelter1.id}"

    expect(page).to have_link("Delete Shelter")

    click_link("Delete Shelter")

    expect(page).to_not have_content("#{shelter1.name} has approved applications and cannot be deleted at this time.")

    expect(current_path).to eq("/shelters")

    expect(page).to have_no_content('humane society')
    expect(page).to have_content('Dogs love dinosaurs')

    visit "/pets"

    expect(page).to_not have_content("Snickers")
    expect(page).to_not have_content("Sadie")
    expect(page).to have_content('Abbey')
  end

  it "when a shelter is deleted so are its reviews" do

    shelter1 = Shelter.create!(name: 'humane society', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")

    review1 = Review.create!(title: "Best Shelter EVER!", rating: "5", content: "I now have my best friend because of this place", shelter_id: shelter1.id)
    review2 = Review.create!(title: "Above Average Shelter", rating: "4", content: "I am pretty sure they gave me a dinosaur not a dog.", picture: "https://s7d2.scene7.com/is/image/PetSmart/5290431", shelter_id: shelter1.id)

    visit "shelters/#{shelter1.id}"

    click_link("Delete Shelter")

    expect { shelter1.reload }.to raise_error ActiveRecord::RecordNotFound
    expect { review1.reload }.to raise_error ActiveRecord::RecordNotFound
    expect { review2.reload }.to raise_error ActiveRecord::RecordNotFound
  end
end
