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
    fill_in "group[name]", with: "My Group"
    click_button "Save Group"
    expect(page).to have_link("My Group")
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
  	click_button "Save Post"
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


feature "group permissions" do
  let(:user) {FactoryGirl.create(:user)}
  let(:user1) {FactoryGirl.create(:user, email:"user1@domain.com")}
  let(:group) {FactoryGirl.create(:group, name: "Others Group")}
  
  scenario "User should not be able to read post of the group which they are not following" do
    group
    capybara_sign_in
    expect(page).not_to have_link("Others Group")
    expect(page).to have_link("Follow")
  end

  scenario "user should be able to read post from the group he is following" do
    [group, user]

    capybara_sign_in
    expect(page).not_to have_link("Others Group")
    expect(page).to have_link("Follow")
    click_link "Follow"
    expect(page).to have_link("Unfollow")
  end

end
  
  feature "My groups" do
    let(:user) {FactoryGirl.create(:user)}
    let(:user1) {FactoryGirl.create(:user, email:'user1@domain.com')}
    let(:group) {FactoryGirl.create(:group, name: "user group", user_id: user.id )}
    let(:group1) {FactoryGirl.create(:group, name: "user1 group", user_id: user1.id )}
    
    scenario "User should able to see all the group he created" do
      group and group1
      capybara_sign_in
      click_link "My Groups"
      expect(page).to have_content("user group")
      expect(page).to have_no_content("user1 group")
    end
  end


  feature "Edit and update post" do
      let(:user) {FactoryGirl.create(:user)}
      let(:group) {FactoryGirl.create(:group, name: "user group", user_id: user.id )}
      let(:post) {FactoryGirl.create(:post, title: "New post", text: "loriem ipsum", user_id: user.id, group_id:group.id)}
    
    scenario "Users should be able to edit and update post they have created" do
      capybara_sign_in
      visit "/groups/#{group.id}/posts/#{post.id}/edit"
      expect(page).to have_selector("textarea")
      expect(page).to have_selector("input")
      fill_in "Title", with: "My post"
      fill_in "Text", with: "post Area"
      click_button "Save Post"
      expect(page).to have_text("My post")
      expect(page).to have_text("post Area")
    end
  
  end

  feature "Delete post" do
    let(:user) {FactoryGirl.create(:user)}
    let(:group) {FactoryGirl.create(:group, name: "user group", user_id: user.id )}
    let(:post) {FactoryGirl.create(:post, title: "New post", text: "loriem ipsum", user_id: user.id, group_id:group.id)}

    scenario "user should be able to delete the post he created" do
      post
      capybara_sign_in
      visit "/groups/#{group.id}/posts/#{post.id}/"
      expect(page).to have_text("New post")
      expect(page).to have_text("loriem ipsum")
      click_link "Delete"
      expect(page).not_to have_text("New post")
      expect(page).not_to have_text("loriem ipsum")
    end
  end


  feature "Request member" do
    let(:user) {FactoryGirl.create(:user)}
    let(:user1) {FactoryGirl.create(:user)}
    let(:group) {FactoryGirl.create(:group, name: "user group", user_id: user1.id )}

    scenario "User can be able to request for member" do
      user
      capybara_sign_in
      user.follow(group)
      visit "/groups/#{group.id}"
      expect(page).to have_link("Request member")
      click_link "Request member"
      expect(page).to have_text("Request pending")
    end
  end

  feature "accept member" do
    let(:user) {FactoryGirl.create(:user)}
    let(:user1) {FactoryGirl.create(:user)}
    let(:group) {FactoryGirl.create(:group, name: "user group", user_id: user.id )}
    let(:member) {FactoryGirl.create(:member, user_id: user1.id, group_id: group.id, is_confirmed: false )}
    scenario "user should be able see the member request" do
      member
      capybara_sign_in
      user.follow(group)
      visit "/groups/#{group.id}"
      click_link "Group Members"
      expect(page).to have_text("Requested users")
      expect(page).to have_text("Members")
      expect(page).to have_text(user1.email)
      expect(page).to have_link("confirm")
    end
  end

  feature "delete member" do
    let(:user) {FactoryGirl.create(:user)}
    let(:user1) {FactoryGirl.create(:user)}
    let(:group) {FactoryGirl.create(:group, name: "user group", user_id: user.id )}
    let(:member) {FactoryGirl.create(:member, user_id: user1.id, group_id: group.id, is_confirmed: true )}
    scenario "user should be able to delete the member" do
      member
      capybara_sign_in
      user.follow(group)
      visit "/groups/#{group.id}"
      click_link "Group Members"
      expect(page).to have_text("Requested users")
      expect(page).to have_text("Members")
      expect(page).to have_text(user1.email)
      expect(page).to have_link("Delete")
    end

  end


  feature "Permission to create post" do
    let(:user) {FactoryGirl.create(:user)}
    let(:user1) {FactoryGirl.create(:user)}
    let(:user2) {FactoryGirl.create(:user)}
    let(:group) {FactoryGirl.create(:group, name: "user group", user_id: user1.id )}
    let(:member1) {FactoryGirl.create(:member, user_id: user.id, group_id: group.id, is_confirmed: true )}
    let(:member2) {FactoryGirl.create(:member, user_id: user2.id, group_id: group.id, is_confirmed: false )}
    scenario "members should be able to create the post" do
      member1
      capybara_sign_in
      user.follow(group)
      visit "/groups/#{group.id}"
      expect(page).to have_link("Create Post")
    end
  end



def capybara_sign_in
  visit "/users/sign_in"
    expect(page).to have_text("Log in")
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
end