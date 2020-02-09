require 'rails_helper'

RSpec.describe "Visitor can view individual applications on their show page" do
  it "applications have show pages" do
    shelter1 = Shelter.create!(name: 'humane society', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")

    snickers = Pet.create!(image: 'https://images-na.ssl-images-amazon.com/images/I/41Q-6cQEOLL._AC_SY400_.jpg', name: 'Snickers', age: 15, sex: 'Female', shelter: shelter1)
    sadie = Pet.create!(image: 'https://images.halloweencostumes.com/products/45834/1-1/dog-dino-pup-costume.jpg', name: 'Sadie', age: 3, sex: "Male", shelter: shelter1)

    application = Application.create!(name: 'Cassie', address: 'nowhere st.', city: 'Denver', state: 'CO', zip: '48204', :phone_number '777-777-7777', :description 'because')

    application.pets << snickers
    application.pets << sadie

    visit "/applications/:id"

    expect(page).to have_content("Cassie")
    expect(page).to have_content("nowhere st.")
    expect(page).to have_content("Denver")
    expect(page).to have_content("CO")
    expect(page).to have_content("48204")
    expect(page).to have_content("777-777-7777")
    expect(page).to have_content("because")
    expect(page).to have_link("Snickers")
    expect(page).to have_link("Sadie")
  end
end
