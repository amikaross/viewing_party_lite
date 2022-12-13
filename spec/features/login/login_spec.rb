require 'rails_helper'

RSpec.describe 'login page', type: :feature do
  it 'when clicking on the "Log In" link on the landing page, I am taken to a login page with fields for entering email / password' do
    visit '/'

    click_link("Log In")

    expect(current_path).to eq("/login")
    expect(page).to have_field(:email)
    expect(page).to have_field(:password)
    expect(page).to have_button("Submit")
  end

  it 'when you fill out the correct information you are taken to your dashboard' do
    user = User.create!(name: "Amanda", email: "amanda@turing.edu", password: "12345", password_confirmation: "12345")

    visit '/login'

    fill_in(:email, with: "amanda@turing.edu")
    fill_in(:password, with: "12345")
    click_button("Submit")

    expect(current_path).to eq("/dashboard")
    expect(page).to have_content("Amanda's Dashboard")  
  end

  it "when you fill out with incorrect password, you are redirected to login and an error is displayed" do 
    user = User.create!(name: "Amanda", email: "amanda@turing.edu", password: "12345", password_confirmation: "12345")

    visit '/login'

    fill_in(:email, with: "amanda@turing.edu")
    fill_in(:password, with: "123456789")
    click_button("Submit")

    expect(current_path).to eq("/login")
    within '#flash-messages' do 
    expect(page).to have_content("Error: Incorrect credentials")
  end
  end
end
