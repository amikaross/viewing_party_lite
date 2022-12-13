require 'rails_helper'

RSpec.describe 'Movies Index Page' do
  describe 'As a user when I visit users/:id/discover' do 
    describe 'and you click the find top rated movies button' do 
      it 'takes you to the top rated movies index page', :vcr do         
        visit "/discover"
        click_button 'Discover The Top Rated Movies'
        
        expect(current_path).to eq("/movies")
        expect(page).to have_content('The Godfather')
        expect(page).to have_content('Vote Average:8.7')
        expect(page).to have_content('Dilwale Dulhania Le Jayenge')
        expect(page).to have_content('Vote Average:8.6')
        expect(page).to have_content('Dou kyu sei – Classmates')
        expect(page).to have_content('Vote Average:8.5')
      end
    end

    describe 'and you fill in the search field and click on find movies' do 
      it 'takes you to the movie from title keywords search', :vcr do
        visit "/discover"

        expect(page).to have_field("q")
        fill_in(:q, with: "Princess space")

        click_button "Find Movies"
        
        expect(current_path).to eq("/movies")
        expect(page).to have_content('Space Princess')
        expect(page).to have_content('Vote Average:0')
        expect(page).to have_content("Crayon Shin-chan: Invoke a Storm! Me and the Space Princess")
        expect(page).to have_content('Vote Average:7.1')
        expect(page).to have_content("My Brother's Wife 4 - Space Princess Choon-hyang")
        expect(page).to have_content('Vote Average:0')
        expect(page).to have_content("My Brother's Wife 4 - Space Princess Choon Hyang")
        expect(page).to have_content('Vote Average:0')
      end

      it 'has links to all the movies show pages', :vcr do 
        visit "/discover"
        
        fill_in(:q, with: "Princess space")
        click_button "Find Movies"

        expect(page).to have_link('Space Princess', href: movie_path(651812))
        expect(page).to have_link('Crayon Shin-chan: Invoke a Storm! Me and the Space Princess', href: movie_path(163772))
        expect(page).to have_link("My Brother's Wife 4 - Space Princess Choon-hyang", href: movie_path(700972))
        expect(page).to have_link("My Brother's Wife 4 - Space Princess Choon Hyang", href: movie_path(930411))
      end
    end
  end
end