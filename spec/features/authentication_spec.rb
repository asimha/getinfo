require_relative '../spec_helper'
require_relative '../rails_helper'

feature "Sign up" do
	scenario "User should be able to sign up with proper data" do
		visit "/users/sign_up"
		expect(page).to have_text("Sign up")
		fill_in "Email", with: "user@yopmail.com"
  		fill_in "Password", with: "Password"
  		fill_in "Password confirmation", with: "Password"
  		click_button "Sign up"
  		expect(page).to have_text("GetInfo")
	end

	
end