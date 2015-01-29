require_relative '../spec_helper'
require_relative '../rails_helper'


feature "Group" do
  before(:each) {
    capybara_sign_in
  }
  let(:user) {FactoryGirl.create(:user)}

  scenario "user should be able to create a group" do
    click_link "Create Group"
    expect(page).to have_selector("*/form/p/input")
    fill_in "groups[name]", with: "My Group"
    click_button "Save Groups"
    expect(page).to have_text("My Group")
  end

end

feature "The user should be able to read and create the post in a group" do

before(:each) {
  capybara_sign_in
}

  let(:user) {FactoryGirl.create(:user)}
  let(:group) {FactoryGirl.create(:group)}
  let(:group1) {FactoryGirl.create(:group)}
  let(:post) {FactoryGirl.create(:post, title: "New post", text: "loriem ipsum", user_id: user.id, group_id:group1.id)}

	scenario "Reader should be able to view the post" do
    post
    visit "/groups/#{post.group_id}/posts"
    expect(page).to have_text("New post")
  end

  scenario "User should be able to see the form to write post" do
    group
    expect(page).to have_text("GetInfo")
    visit "/groups/#{group.id}/posts"
    click_link "Create post"
  	expect(page).to have_selector("textarea")
  	expect(page).to have_selector("input")
    end
  
  scenario "User should be able to fill the form and save the post" do
    visit "/groups/#{group.id}/posts/new"
  	fill_in "Title", with: "My post"
  	fill_in "Text", with: "post Area"
  	click_button "Save Posts"
    expect(page).to have_text("My post")
    expect(page).to have_text("post Area")
    expect(page).to have_no_content("New post")
  end

end

feature "View the complete post" do

  let(:user) {FactoryGirl.create(:user)}
  let(:group) {FactoryGirl.create(:group)}
  let(:post) {FactoryGirl.create(:post, title: "New post", text: "loriem ipsum loriem ipsum sdfsdf sdkjfsdf; sldfhsdlfhj sd;fjlhjsdlfg sdjfsdfg kgsdf;sdgf loriem ipsum", user_id: user.id, group_id:group.id)}

  scenario "User should be able to view complete post details" do
    post
    capybara_sign_in
    visit "/groups/#{post.group_id}/posts"
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