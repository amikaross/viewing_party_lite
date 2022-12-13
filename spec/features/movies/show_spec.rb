require 'rails_helper'

RSpec.describe 'The movie show page' do 
  describe "As a visitor" do 
    describe "If I visit the movies show page and click the link for Create Viewing Party" do
      it "redirects me back to the show page, with an alert that I must be logged in", :vcr do         
        visit movie_path(128)
  
        click_button('Create Viewing Party For Princess Mononoke')
        
        expect(current_path).to eq(movie_path(128))
        within "#flash-messages" do 
          expect(page).to have_content("You must register or log in to create a viewing party")
        end
      end
    end
  end

  describe 'As a logged in user when I visit a movie show page' do 
    it 'displays a button to create a viewing party and a button to return to discover', :vcr do 
      user = User.create!(name: "Amanda", email: "amanda@turing.edu", password: "12345", password_confirmation: "12345")
      
      visit '/login'

      fill_in(:email, with: 'amanda@turing.edu')
      fill_in(:password, with: '12345')
      click_button("Submit")

      visit movie_path(128)

      expect(page).to have_button('Create Viewing Party For Princess Mononoke')
      expect(page).to have_button('Discover Page')

      click_button('Discover Page')
      
      expect(current_path).to eq("/discover")
    end

    it 'displays the movie details: title, vote average, runtime, genre(s), summary', :vcr do 
      user = User.create!(name: "Amanda", email: "amanda@turing.edu", password: "12345", password_confirmation: "12345")
      
      visit '/login'

      fill_in(:email, with: 'amanda@turing.edu')
      fill_in(:password, with: '12345')
      click_button("Submit")

      visit movie_path(128)

      expect(page).to have_content("Princess Mononoke")
      expect(page).to have_content("Vote: 8.346")
      expect(page).to have_content("Runtime: 2hr 14min")
      expect(page).to have_content("Genre: Adventure, Fantasy, Animation")
      expect(page).to have_content("Summary:")
      expect(page).to have_content("Ashitaka, a prince of the disappearing Emishi people, is cursed by a demonized boar god and must journey to the west to find a cure. Along the way, he encounters San, a young human woman fighting to protect the forest, and Lady Eboshi, who is trying to destroy it. Ashitaka must find a way to bring balance to this conflict.")
    end

    it 'displays the first 10 cast members', :vcr do 
      user = User.create!(name: "Amanda", email: "amanda@turing.edu", password: "12345", password_confirmation: "12345")
      
      visit '/login'

      fill_in(:email, with: 'amanda@turing.edu')
      fill_in(:password, with: '12345')
      click_button("Submit")

      visit movie_path(128)

      expect(page).to have_content("Ashitaka (voice): Youji Matsuda")
      expect(page).to have_content("San (voice): Yuriko Ishida")
      expect(page).to have_content("Eboshi-gozen (voice): Yūko Tanaka")
      expect(page).to have_content("Jiko-bô (voice): Kaoru Kobayashi")
      expect(page).to have_content("Kouroku (voice): Masahiko Nishimura")
      expect(page).to have_content("Gonza (voice): Tsunehiko Kamijô")
      expect(page).to have_content("Toki (voice): Sumi Shimamoto")
      expect(page).to have_content("Yama-inu (voice): Tetsu Watanabe")
      expect(page).to have_content("Tatari-gami (voice): Mitsuru Satô")
      expect(page).to have_content("Usi-kai (voice): Akira Nagoya")
    end

    it 'displays count of total reviews and all the authors and their information', :vcr do 
      user = User.create!(name: "Amanda", email: "amanda@turing.edu", password: "12345", password_confirmation: "12345")
      
      visit '/login'

      fill_in(:email, with: 'amanda@turing.edu')
      fill_in(:password, with: '12345')
      click_button("Submit")

      visit movie_path(128)

      expect(page).to have_content("2 Reviews:")
      expect(page).to have_content("Andres Gomez")
      expect(page).to have_content("tmdb79319797")
    end
  end
end