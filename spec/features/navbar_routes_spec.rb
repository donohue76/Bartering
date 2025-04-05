require 'rails_helper'

RSpec.feature "User Login and profile routes", type: :feature do
    describe "Navbar and profile displays when user signs in" do
        # this tests the navbar and profile page when user logs in
        it "can sign in and be taken to home page", js: true do
            create_user
            click_link_or_button "Logout"
            click_link_or_button "Login"
            expect(page).to have_content('Log in')
            fill_in 'Email', with: 'david@learn.com'
            fill_in 'Password', with: 'password123'

            click_button "Log in"
            expect(current_path).to eq('/')

            click_link_or_button "Profile"
            expect(page).to have_content("My Profile Page")
        end
        it "can see listings from the profile page" do
            create_user
            click_link_or_button 'Profile'
            expect(page).to have_content('Listing Information')
        end

    end
end

def create_user
  visit '/'
  expect(page).to have_content("Sign up")
  click_link_or_button "Sign up"
  expect(page).to have_content("Sign up")
  fill_in "user_email", with: "david@learn.com"
  fill_in "user_password", with: "password123"
  fill_in "user_password_confirmation", with: "password123"

  click_button "Sign up"
  expect(current_path).to eq('/')
end
