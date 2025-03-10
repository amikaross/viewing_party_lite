require 'rails_helper'

RSpec.describe "the User Show page aka the user's dashboard" do 
  describe "as a visitor" do 
    describe "when I try to visit /users/:d where id is a valid id, without hvaing logged in" do
      it "redirects me to the landing page and displays an alert" do 
        user = User.create!(name: 'Amanda', email: 'amanda@turing.edu', password: "12345", password_confirmation: "12345")

        visit "/dashboard"

        expect(current_path).to eq("/")
        within "#flash-messages" do 
          expect(page).to have_content("You do not have permission to access that page")
        end
      end
    end
  end

  describe "As a logged in user" do 
    describe "when I visit '/users/:id' where id is a valid user id" do 
      it "shows '<user name>'s Dashboard', a Discover Movies button, and a list of that user's viewing parties", :vcr do 
        user = User.create!(name: 'Amanda', email: 'amanda@turing.edu', password: "12345", password_confirmation: "12345")
        user_2 = User.create!(name: "James", email: "james@turing.edu", password: "12345", password_confirmation: "12345")
        user_3 = User.create!(name: "Annie", email: "annie@turing.edu", password: "12345", password_confirmation: "12345")
        user_4 = User.create!(name: "Naomi", email: "naomi@turing.edu", password: "12345", password_confirmation: "12345")

        party_1 = ViewingParty.create!(movie_id: 129, movie_title: "Spirited Away", duration: 180, date: '2022-12-12', start_time: '17:00', run_time: 150)
        party_2 = ViewingParty.create!(movie_id: 680, movie_title: "Pulp Fiction", duration: 200, date: '2022-12-13', start_time: '19:00', run_time: 150)
        UserViewingParty.create!(user: user, viewing_party: party_1, status: "Hosting")
        UserViewingParty.create!(user: user_3, viewing_party: party_1, status: "Invited")
        UserViewingParty.create!(user: user_4, viewing_party: party_1, status: "Invited")

        UserViewingParty.create!(user: user, viewing_party: party_2, status: "Invited")
        UserViewingParty.create!(user: user_3, viewing_party: party_2, status: "Invited")
        UserViewingParty.create!(user: user_2, viewing_party: party_2, status: "Hosting")

        visit '/login'

        fill_in(:email, with: 'amanda@turing.edu')
        fill_in(:password, with: '12345')
        click_button("Submit")

        visit "/dashboard"

        expect(page).to have_content("Amanda's Dashboard")
        expect(page).to have_button("Discover Movies")

        within "#viewing-party-#{party_1.id}" do 
          expect(page).to have_link("Spirited Away", href: movie_path(party_1.movie_id))
          expect(page).to have_content("December 12, 2022")
          expect(page).to have_content("5:00 PM")
          expect(page).to have_content("Hosting")
          within "#invitees" do 
            expect(page).to have_content("Annie")
            expect(page).to have_content("Naomi")
          end
        end

        within "#viewing-party-#{party_2.id}" do 
          expect(page).to have_link("Pulp Fiction", href: movie_path(party_2.movie_id))
          expect(page).to have_content("December 13, 2022")
          expect(page).to have_content("7:00 PM")
          expect(page).to have_content("Invited")
          expect(page).to have_content("Host: James")
          within "#invitees" do 
            expect(page).to have_content("Annie")
            expect(page).to have_content("Amanda")
          end
        end

        click_button("Discover Movies")
        
        expect(current_path).to eq("/discover")
      end
    end
  end
end