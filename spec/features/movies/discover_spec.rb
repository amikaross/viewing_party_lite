require 'rails_helper'

RSpec.describe 'Discover Movies Page' do
  describe 'As a user when I visit users/:id/discover' do 
    it 'the discover page has a button to discover the top rated movies', :vcr do
      visit "/discover"

      click_button 'Discover The Top Rated Movies'

      expect(current_path).to eq("/movies")
    end
    
    it 'has a search field to enter movie title keywords', :vcr do
      visit "/discover"

      expect(page).to have_field("q")
      fill_in(:q, with: "Shawshank")
      click_button "Find Movies"

      expect(current_path).to eq("/movies")
    end

    it "reloads the page without returing results if the keyword search is blank and find movies is clicked" do 
      visit "/discover"
      click_button "Find Movies"

      expect(current_path).to eq("/discover")
      within '#flash-messages' do
        expect(page).to have_content("Error: You must provide a query")
      end
    end
  end
end