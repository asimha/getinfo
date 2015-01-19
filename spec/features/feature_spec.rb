require_relative '../spec_helper'
require_relative '../rails_helper'

feature "The user should be able to read and create the blog" do

	before(:each) do 
		visit "/"
	end

	scenario "Reader should be able to view the blog" do
    expect(page).to have_text("First blog")
  end

  scenario "User should be able to see create blog button" do
    click_link "Create Blog"
  	expect(page).to have_selector("textarea")
  	expect(page).to have_selector("input")
  	fill_in "Title", with: "My Blog"
  	fill_in "Text", with: "Blog Area"
  	click_button "Save Blogs"
    expect(page).to have_text("My Blog")
    expect(page).to have_text("Blog Area")
  end

end
