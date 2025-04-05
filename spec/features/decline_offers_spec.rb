require 'rails_helper'

RSpec.feature "DeclineOffers", type: :feature do
  describe "As a user I" do
    it "can decline an offer" do
      # I can make a comment
      create_new_barter
      create_comment

      #need to decline comments
      expect(current_path).to eq '/barters/1'
      expect(page).to have_button 'Accept'
      expect(page).to have_button 'Decline'

      click_button 'Decline'
      expect(page).to_not have_button 'Accept'
      expect(page).to_not have_button 'Decline'
      expect(page).to have_content 'New Comment'
    end

    it "can accept an offer" do
      create_new_barter
      create_another_comment
      
      #need to decline comments
      expect(current_path).to eq '/barters/2'
      expect(page).to have_button 'Accept'
      expect(page).to have_button 'Decline'

      click_button 'Accept'
      expect(page).to_not have_button 'Accept'
      expect(page).to_not have_button 'Decline'
      expect(page).to_not have_content 'New Comment'
    end
  end

end

def create_new_barter
  visit '/'
  expect(page).to have_content("Home")
  click_link "Sign up"
  # save_and_open_page
  expect(current_path).to eq '/users/sign_up'
  fill_in "user_email", with: "test@learn.com"
  fill_in "user_password", with: "test12345"
  fill_in "user_password_confirmation", with: "test12345"
  click_button "Sign up"
  expect(current_path).to eq('/')
  # p user = User.first
  visit "/barters/new"
  expect(current_path).to eq "/barters/new"
  expect(page).to have_content "Create New Listing"
  expect(page).to have_content "Product"
  expect(page).to have_content "Description"
  fill_in 'Product', with: 'lemon'
  fill_in 'barter[description]', with: '20 lemons'
  choose('Goods')
  select 'Hillcrest', from: "Neighborhood"
  fill_in 'barter[interested_in]', with: 'banana'
  fill_in 'Expiration Date', with: '05/01/2016'
  click_button('newbarter')
  expect(page).to have_content('Barter was successfully created.')
  expect(page).to have_content('lemon')
  expect(page).to have_content('20 lemons')
  expect(page).to have_content('Goods')
  expect(page).to have_content('hillcrest')
  expect(page).to have_content('2016-01-05')
end

def create_comment
  user = User.last
  barter = Barter.last

  visit '/barters/1'
  expect(page).to have_content("TRADE")
  expect(current_path).to eq('/barters/1')
  expect(page).to have_content("Message")
  click_link_or_button "New Comment"
  expect(page).to have_content("New Comment")
  fill_in "Comment", with: "words"
  click_button "Create Comment"
  expect(current_path).to eq('/barters/1')
  expect(page).to have_content("words")
end

def create_another_comment
  user = User.last
  barter = Barter.last

  visit '/barters/2'
  expect(page).to have_content("TRADE")
  expect(current_path).to eq('/barters/2')
  expect(page).to have_content("Message")
  click_link_or_button "New Comment"
  expect(page).to have_content("New Comment")
  fill_in "Comment", with: "words"
  click_button "Create Comment"
  expect(current_path).to eq('/barters/2')
  expect(page).to have_content("words")
end
