require 'rails_helper'

RSpec.describe 'logout', type: :feature do
  describe "As a logged in user" do 
    describe "When I visit the landing page" do 
      it 'has a list of existing users, no link to login or create user, and a link to logout' do
        user1 = User.create!(name: 'Amanda', email: 'amanda@turing.edu', password: "12345", password_confirmation: "12345")
        user2 = User.create!(name: 'James', email: 'james@turing.edu', password: "12345", password_confirmation: "12345")
        user3 = User.create!(name: 'Pat', email: 'pat@turing.edu', password: "12345", password_confirmation: "12345")
        
        visit "/"
        click_link("Log In")
        fill_in(:email, with: "amanda@turing.edu")
        fill_in(:password, with: "12345")
        click_button("Submit")

        visit "/"
        expect(page).to have_content('Existing Users')
        expect(page).to_not have_link("Log In", href: "/login")
        expect(page).to_not have_button('Create A New User')

        click_link("Log Out", href: "/logout")

        expect(current_path).to eq("/")
        expect(page).to_not have_content('Existing Users')
        expect(page).to have_link("Log In", href: "/login")
        expect(page).to have_button('Create A New User')
      end
    end
  end
end
