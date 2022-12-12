require "rails_helper"

RSpec.describe "the User registration page" do 
  describe "when a user visits '/register'" do 
    it "shows a form to register, once registered they're directed to the user show page" do 
      visit '/'

      expect(page).to_not have_content('amanda@turing.edu')

      click_on('Create A New User')

      expect(current_path).to eq(register_path)
      expect(page).to have_field(:name)
      expect(page).to have_field(:email)
      expect(page).to have_field(:password)
      expect(page).to have_field(:password_confirmation)
      expect(page).to have_button('Create New User')

      fill_in(:name, with: 'Amanda')
      fill_in(:email, with: 'amanda@turing.edu')
      fill_in(:password, with: 'test1234')
      fill_in(:password_confirmation, with: 'test1234')
      click_button('Create New User')

      last_created = User.last
      expect(current_path).to eq(user_path(last_created))

      visit '/'
      
      expect(page).to have_content('amanda@turing.edu')
    end

    it "doesn't allow you to leave fields blank" do 
      visit register_path
      fill_in(:name, with: 'Amanda')
      click_button('Create New User')

      expect(current_path).to eq(register_path)
      within '#flash-messages' do 
        expect(page).to have_content("Error: Email can't be blank, Password can't be blank, Password confirmation doesn't match Password")
      end

      fill_in(:email, with: 'amanda@turing.edu')
      click_button('Create New User')

      expect(current_path).to eq(register_path)
      within '#flash-messages' do 
        expect(page).to have_content("Error: Name can't be blank")
      end
    end

    it "doesn't allow you to register a non-unique email address" do 
      User.create!(name: "Mandy", email: "amanda@turing.edu", password: "12345", password_confirmation: "12345")
      visit register_path
      fill_in(:name, with: 'Amanda')
      fill_in(:email, with: 'amanda@turing.edu')
      click_button('Create New User')

      expect(current_path).to eq(register_path)
      within '#flash-messages' do 
        expect(page).to have_content("Error: Email has already been taken")
      end
    end

    it "doesn't allow to have unmatching password / password_confirmation fields" do 
      visit register_path
      fill_in(:name, with: 'Amanda')
      click_button('Create New User')

      expect(current_path).to eq(register_path)
      within '#flash-messages' do 
        expect(page).to have_content("Error: Email can't be blank")
      end

      fill_in(:email, with: 'amanda@turing.edu')
      click_button('Create New User')

      expect(current_path).to eq(register_path)
      within '#flash-messages' do 
        expect(page).to have_content("Error: Name can't be blank")
      end
    end
  end
end