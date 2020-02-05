require 'rails_helper'

RSpec.describe 'as a visitor', type: :feature do
  describe 'and I visit a shelters page' do
    it 'I can edit the reviews left on a shelters page' do
      shelter1 = Shelter.create!(name: 'humane society', address: "1234 st", city: 'Denver', state: 'Colorado', zip: "29572")
      review1 = Review.create!(title: "Best Shelter EVER!", rating: "5", content: "I now have my best friend because of this place", shelter_id: shelter1.id)
      title = "Turns out these are Dino's after all"
      content = "I didnt notice until I got home that this dog is actually 100 feet tall 5/5 would recommend"
      rating = "5"
      visit "shelters/#{shelter1.id}"

      click_on 'Edit'
      # binding.pry
      expect(find_field(:title).value).to eq (review1.title)
      expect(find_field(:rating).value).to eq (review1.rating)
      expect(find_field(:content).value).to eq (review1.content)
      expect(find_field(:picture).value).to eq ((review1.picture) || (""))
      expect(current_path).to eq("/reviews/#{review1.id}/edit")
      fill_in :title, with: title
      fill_in :content, with: content
      click_on 'Update Review'


      expect(current_path).to eq("/shelters/#{review1.shelter_id}")
      expect(page).to_not have_content("Best Shelter EVER!")
      expect(page).to have_content("Turns out these are Dino's after all")
      expect(page).to have_content("100 feet tall")

    end
  end

end
