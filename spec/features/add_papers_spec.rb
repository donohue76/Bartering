require 'rails_helper'

RSpec.feature "Create New Barter", type: :feature do
  describe "As a user I" do
    #this test creates a new user and a new barter
    it "can fill in form and create a new barter" do
      visit '/'
      expect(page).to have_content("Home")
      click_link "Sign up"
      expect(current_path).to eq('/users/sign_up')
      fill_in "user_email", with: "test@learn.com"
      fill_in "user_password", with: "test12345"
      fill_in "user_password_confirmation", with: "test12345"
      click_button "Sign up"
      expect(current_path).to eq('/')
      visit "barters/new"
      fill_in 'barter[product]', with: 'apples'
      fill_in 'barter[description]', with: 'delicious'
      choose('Goods')
      select 'Hillcrest', from: "Neighborhood"
      fill_in 'barter[interested_in]', with: 'lemons'
      fill_in 'expiration', with: '05/01/2016'
      page.find('#image').click
      attach_file "image", "spec/images/apples2.jpeg"
      click_button('submit')
      expect(page).to have_content('Barter was successfully created')
      expect(current_path).to eq('/barters/1')
      expect(page).to have_content('apples')

    end
  end
end
