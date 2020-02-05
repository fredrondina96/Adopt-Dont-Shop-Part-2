require "rails_helper"

RSpec.describe "Visitor can favorite and view their favorites" do
  it "sees total of favorited pets at the top of every page" do

    visit "/pets"

    expect(page).to have_content("Favorites: 3")

    visit "/shelters"

    expect(page).to have_content("Favorites: 3")
  end
end
