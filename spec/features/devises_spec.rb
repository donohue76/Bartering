require 'rails_helper'

# RSpec.feature "Devises", type: :feature, js: true do
RSpec.feature "Devises", type: :feature do

  # Story: As a user I can sign up, log in, log out.
  describe "sign up with email address and password" do
    it "should go to sign up page" do
      visit 'users/sign_up'
      expect(page).to have_content("Sign up")
    end

    #  Story: As a user I can sign up with email address and password.
    it "should sign up" do
      visit 'users/sign_up'
      expect(page).to have_content("Sign up")
      fill_in "user_email", with: "me@learn.com"
      fill_in "user_password", with: "notch8learn"
      fill_in "user_password_confirmation", with: "notch8learn"
      click_button "Sign up"
      expect(current_path).to eq('/')
      expect(page).to have_content("TRADE")
    end
  end

  # As a user I can Login and out
  describe "login a user" do
    it "should go to the login page" do
      visit '/'
      expect(page).to have_content("Login")
    end

    # Story: As a user I can log in and out.
    it "should login and logout a user" do
      visit '/'
      expect(page).to have_content("Home")
      click_link "Sign up"
      expect(current_path).to eq('/users/sign_up')
      fill_in "user_email", with: "me@learn.com"
      fill_in "user_password", with: "notch8learn"
      fill_in "user_password_confirmation", with: "notch8learn"
      click_button "Sign up"
      expect(current_path).to eq('/')
      click_link "Logout"
      expect(current_path).to eq('/')
      click_link "Login"
      expect(current_path).to eq('/users/sign_in')
      fill_in "Email", with: "me@learn.com"
      fill_in "Password", with: "notch8learn"
      click_button "Log in"
      expect(current_path).to eq('/')
      expect(page).to have_content("Cupcake ipsum")
    end
  end

  def create_user_me
    visit 'users/sign_up'
    expect(page).to have_content("Sign up")
    fill_in "user_email", with: "me@learn.com"
    fill_in "user_password", with: "password"
    fill_in "user_password_confirmation", with: "password"
    click_button "Sign up"
  end

  def create_user_you
    visit 'users/sign_up'
    expect(page).to have_content("Sign up")
    fill_in "user_email", with: "you@learn.com"
    fill_in "user_password", with: "password"
    fill_in "user_password_confirmation", with: "password"
    click_button "Sign up"
  end

  def login_user_me
    # visit 'users/sign_in'
    expect(page).to have_content("Login")
    fill_in "user_email", with: "me@learn.com"
    fill_in "user_password", with: "password"
    click_button "Log in"
  end

  def Logout
    click_link "Logout"
    expect(current_path).to eq('/')
    expect(page).to have_content("TRADE")
  end
end
