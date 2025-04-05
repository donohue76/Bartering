require 'rails_helper'

RSpec.feature "Profile page and Listings ", type: :feature do
    describe "Profile page lists barters and login info" do
        # this tests the profile page and listings
        it "can see listings from the profile page" do
            create_user
            create_barter
            click_link_or_button "Profile"
            expect(page).to have_content("lemon")
        end
    end
end
def create_user
  visit "/"
  expect(page).to have_content("Sign up")
  click_link_or_button "Sign up"
  expect(page).to have_content("Sign up")
  fill_in "user_email", with: "david@learn.com"
  fill_in "user_password", with: "password123"
  fill_in "user_password_confirmation", with: "password123"
  click_button "Sign up"
  expect(current_path).to eq("/")
end
def create_barter
  visit "/barters/new"
  expect(page).to have_content("Create New Listing")
  expect(page).to have_content("Submit")
  fill_in "Product", with: "lemon"
  fill_in "barter[description]", with: "20 lemons"
  # find('input[type="textarea"]').first.fill_in with: "20 lemons"
  #select 'Goods', from: "radio"
  choose("Goods")
  select "Hillcrest", from: "Neighborhood"
  fill_in "barter[interested_in]", with: "limes"
  fill_in "Expiration", with: "2016-01-20"
  click_link_or_button "submit"
  expect(page).to have_content("lemon")
  expect(page).to have_content("hillcrest")
end
