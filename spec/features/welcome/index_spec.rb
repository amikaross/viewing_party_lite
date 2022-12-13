require 'rails_helper'

RSpec.describe 'landing page', type: :feature do
  describe 'as a visitor' do 
   describe "when I visit the landing page" do  
      it 'has a landing page with an application title' do
        visit '/'

        expect(page).to have_content('Viewing Party Lite')
      end

      it 'has a button to create a new user' do
        visit '/'

        expect(page).to have_button('Create A New User')
      end

      it "has a button to log in" do 
        visit "/"

        expect(page).to have_link("Log In", href: "/login")
      end
    end
  end

  describe "As a logged in user" do 
    describe "When I visit the landing page" do 
      it 'has a list of existing users, no link to login or create user, and a link to logout' do
        user1 = User.create!(name: 'Amanda', email: 'amanda@turing.edu', password: "12345", password_confirmation: "12345")
        user2 = User.create!(name: 'James', email: 'james@turing.edu', password: "12345", password_confirmation: "12345")
        user3 = User.create!(name: 'Pat', email: 'pat@turing.edu', password: "12345", password_confirmation: "12345")
        
        visit '/login'

        fill_in(:email, with: 'amanda@turing.edu')
        fill_in(:password, with: '12345')
        click_button("Submit")

        visit "/"

        expect(page).to have_content('Existing Users')
        expect(page).to have_content(user1.name)
        expect(page).to have_content(user1.email)
        expect(page).to have_content(user2.name)
        expect(page).to have_content(user2.email)  
        expect(page).to have_content(user3.name)
        expect(page).to have_content(user3.email)

        expect(page).to_not have_link("Log In", href: "/login")
        expect(page).to_not have_button('Create A New User')

        expect(page).to have_link("Log Out", href: "/logout")
      end

      it 'has a link to return to the welcome page at the top of every page' do
        visit '/'
        expect(page).to have_link("Home")
      end
    end
  end
end
