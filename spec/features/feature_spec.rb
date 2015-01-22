require_relative '../spec_helper'
require_relative '../rails_helper'

feature "The user should be able to read and create the blog" do

  let(:user) {FactoryGirl.create(:user)}

	scenario "Reader should be able to view the blog" do
    capybara_sign_in
    visit "/"
    expect(page).to have_text("GetInfo")
  end

  scenario "User should be able to create and view blog" do
    capybara_sign_in
    expect(page).to have_text("GetInfo")
    click_button "Create Blog"
  	expect(page).to have_selector("textarea")
  	expect(page).to have_selector("input")
  	fill_in "Title", with: "My Blog"
  	fill_in "Text", with: "Blog Area"
  	click_button "Save Blogs"
    expect(page).to have_text("My Blog")
    expect(page).to have_text("Blog Area")
  end

end

feature "View the complete blog" do

  let(:user) {FactoryGirl.create(:user)}
  let(:blog) {FactoryGirl.create(:blog, title: "New Blog", text: "loriem ipsum loriem ipsum sdfsdf sdkjfsdf; sldfhsdlfhj sd;fjlhjsdlfg sdjfsdfg kgsdf;sdgf loriem ipsum", user_id: user.id)}

  scenario "User should be able to view complete blog details" do
    [blog]
    capybara_sign_in
    visit "/"
    expect(page).to have_text("New Blog")
    expect(page).to have_text("loriem ipsum")
    click_button "Read More"
    expect(page).to have_text("New Blog")
    expect(page).to have_text("loriem ipsum loriem ipsum sdfsdf sdkjfsdf; sldfhsdlfhj sd;fjlhjsdlfg sdjfsdfg kgsdf;sdgf loriem ipsum")
  end

end

def capybara_sign_in
  visit "/users/sign_in"
    expect(page).to have_text("Log in")
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
end
