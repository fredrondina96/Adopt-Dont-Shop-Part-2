require 'rails_helper'

RSpec.describe "Visitors can select pets from their favorites to apply for" do

  it "applys for a pet" do
    shelter1 = Shelter.create!(name: 'humane society', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")

    snickers = Pet.create!(image: 'https://images-na.ssl-images-amazon.com/images/I/41Q-6cQEOLL._AC_SY400_.jpg', name: 'Snickers', age: 15, sex: 'Female', shelter: shelter1)
    sadie = Pet.create!(image: 'https://images.halloweencostumes.com/products/45834/1-1/dog-dino-pup-costume.jpg', name: 'Sadie', age: 3, sex: "Male", shelter: shelter1)
    abbey = Pet.create!(image: 'https://petcostumecenter.com/wp-content/uploads/2019/08/Pupasaurus-Rex-T-Rex-Dog-Cat-Costume-.png', name: 'Abbey', age: 6, sex: "Male", shelter: shelter1)

    visit "/pets/#{snickers.id}"

    click_link("Favorite")

    visit "/pets/#{sadie.id}"

    click_link("Favorite")

    visit "/pets/#{abbey.id}"

    click_link("Favorite")

    visit "/favorites"

    click_link("Adopt")

    expect(current_path).to eq("/application/new")

    within("#pet-#{snickers.id}") do
      page.check
    end
    within("#pet-#{sadie.id}") do
      page.check
    end
    within("#pet-#{abbey.id}") do
      page.check
      page.uncheck
    end

    fill_in "Name", with: "Cassie Achzenick"
    fill_in "Address", with: "24025 Nothing st"
    fill_in "City", with: "Denver"
    fill_in "State", with: "CO"
    fill_in "Zip", with: "98027"
    fill_in "Phone Number", with: "777-777-7777"
    fill_in "Description of why you'd make a good home for this/these pet(s)", with: "Becuase I love them"

    click_button "Submit My Application"

    #flash message:
    expect(page).to have_content("You have successfully completed your application!!!")

    expect(current_path).to eq("/favorites")

    expect(page).to have_no_content("Snickers")
    expect(page).to have_no_content("Sadie")
    expect(page).to have_content("Abbey")
  end

  it "doesnt submit application if information is missing" do
    shelter1 = Shelter.create!(name: 'humane society', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")

    snickers = Pet.create!(image: 'https://images-na.ssl-images-amazon.com/images/I/41Q-6cQEOLL._AC_SY400_.jpg', name: 'Snickers', age: 15, sex: 'Female', shelter: shelter1)
    sadie = Pet.create!(image: 'https://images.halloweencostumes.com/products/45834/1-1/dog-dino-pup-costume.jpg', name: 'Sadie', age: 3, sex: "Male", shelter: shelter1)
    abbey = Pet.create!(image: 'https://petcostumecenter.com/wp-content/uploads/2019/08/Pupasaurus-Rex-T-Rex-Dog-Cat-Costume-.png', name: 'Abbey', age: 6, sex: "Male", shelter: shelter1)
    
    visit "/pets/#{snickers.id}"

    click_link("Favorite")

    visit "/pets/#{sadie.id}"

    click_link("Favorite")

    visit "/pets/#{abbey.id}"

    click_link("Favorite")

    visit "/favorites"

    click_link("Adopt")

    expect(current_path).to eq("/application/new")

    within("#pet-#{snickers.id}") do
      page.check
    end
    within("#pet-#{sadie.id}") do
      page.check
    end
    within("#pet-#{abbey.id}") do
      page.check
      page.uncheck
    end

    fill_in "Address", with: "24025 Nothing st"
    fill_in "City", with: "Denver"
    fill_in "State", with: "CO"
    fill_in "Zip", with: "98027"
    fill_in "Phone Number", with: "777-777-7777"
    fill_in "Description of why you'd make a good home for this/these pet(s)", with: "Becuase I love them"

    click_button "Submit My Application"

    expect(current_path).to eq('/application/new')

    expect(page).to have_content("You must complete all fields on this form in order to submit your application.")

    fill_in "Name", with: "Cassie Achzenick"
    fill_in "City", with: "Denver"
    fill_in "State", with: "CO"
    fill_in "Zip", with: "98027"
    fill_in "Phone Number", with: "777-777-7777"
    fill_in "Description of why you'd make a good home for this/these pet(s)", with: "Becuase I love them"

    click_button "Submit My Application"

    expect(current_path).to eq('/application/new')

    expect(page).to have_content("You must complete all fields on this form in order to submit your application.")

    fill_in "Name", with: "Cassie Achzenick"
    fill_in "Address", with: "24025 Nothing st"
    fill_in "State", with: "CO"
    fill_in "Zip", with: "98027"
    fill_in "Phone Number", with: "777-777-7777"
    fill_in "Description of why you'd make a good home for this/these pet(s)", with: "Becuase I love them"

    click_button "Submit My Application"

    expect(current_path).to eq('/application/new')

    expect(page).to have_content("You must complete all fields on this form in order to submit your application.")

    fill_in "Name", with: "Cassie Achzenick"
    fill_in "Address", with: "24025 Nothing st"
    fill_in "City", with: "Denver"
    fill_in "Zip", with: "98027"
    fill_in "Phone Number", with: "777-777-7777"
    fill_in "Description of why you'd make a good home for this/these pet(s)", with: "Becuase I love them"

    click_button "Submit My Application"

    expect(current_path).to eq('/application/new')

    expect(page).to have_content("You must complete all fields on this form in order to submit your application.")

    fill_in "Name", with: "Cassie Achzenick"
    fill_in "Address", with: "24025 Nothing st"
    fill_in "City", with: "Denver"
    fill_in "State", with: "CO"
    fill_in "Phone Number", with: "777-777-7777"
    fill_in "Description of why you'd make a good home for this/these pet(s)", with: "Becuase I love them"

    click_button "Submit My Application"

    expect(current_path).to eq('/application/new')

    expect(page).to have_content("You must complete all fields on this form in order to submit your application.")

    fill_in "Name", with: "Cassie Achzenick"
    fill_in "Address", with: "24025 Nothing st"
    fill_in "City", with: "Denver"
    fill_in "State", with: "CO"
    fill_in "Zip", with: "98027"
    fill_in "Description of why you'd make a good home for this/these pet(s)", with: "Becuase I love them"

    click_button "Submit My Application"

    expect(current_path).to eq('/application/new')

    expect(page).to have_content("You must complete all fields on this form in order to submit your application.")

    fill_in "Name", with: "Cassie Achzenick"
    fill_in "Address", with: "24025 Nothing st"
    fill_in "City", with: "Denver"
    fill_in "State", with: "CO"
    fill_in "Zip", with: "98027"
    fill_in "Phone Number", with: "777-777-7777"

    click_button "Submit My Application"

    expect(current_path).to eq('/application/new')

    expect(page).to have_content("You must complete all fields on this form in order to submit your application.")
  end
end
