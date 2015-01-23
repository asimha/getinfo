require_relative '../spec_helper'
require_relative '../rails_helper'

feature "The user should be able to read and create the post" do

  let(:user) {FactoryGirl.create(:user)}

	scenario "Reader should be able to view the post" do
    capybara_sign_in
    visit "/"
    expect(page).to have_text("GetInfo")
  end

  scenario "User should be able to create and view post" do
    capybara_sign_in
    expect(page).to have_text("GetInfo")
    click_button "Create post"
  	expect(page).to have_selector("textarea")
  	expect(page).to have_selector("input")
  	fill_in "Title", with: "My post"
  	fill_in "Text", with: "post Area"
  	click_button "Save Posts"
    expect(page).to have_text("My post")
    expect(page).to have_text("post Area")
  end

end

feature "View the complete post" do

  let(:user) {FactoryGirl.create(:user)}
  let(:post) {FactoryGirl.create(:post, title: "New post", text: "loriem ipsum loriem ipsum sdfsdf sdkjfsdf; sldfhsdlfhj sd;fjlhjsdlfg sdjfsdfg kgsdf;sdgf loriem ipsum", user_id: user.id)}

  scenario "User should be able to view complete post details" do
    [post]
    capybara_sign_in
    visit "/"
    expect(page).to have_text("New post")
    expect(page).to have_text("loriem ipsum")
    click_button "Read More"
    expect(page).to have_text("New post")
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
