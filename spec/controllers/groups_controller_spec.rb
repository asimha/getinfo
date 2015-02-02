require 'rails_helper'

RSpec.describe GroupsController, :type => :controller do

  let(:user) {FactoryGirl.create(:user)}
  let(:group0) {FactoryGirl.create(:group)}
  let(:group1) {FactoryGirl.create(:group, user_id: user.id)}
  let(:group2) {FactoryGirl.create(:group)}
  let(:post1) {FactoryGirl.create(:post, group_id: group0.id)}
  let(:post2) {FactoryGirl.create(:post, group_id: group1.id)}

  before(:each) do
   sign_in(user)
  end

  describe "GET index" do
    it "returns all the group" do
      get :index
      expect(assigns[:groups]).to include(group0, group1, group2)
    end
  end

  describe "POST create" do
    it "should able to create the group" do
      sign_in(user)
      group_params = {
        groups: {
          name: "My Group",
        }
      }
      expect do
        post :create, group_params
      end.to change(Group, :count).by(1)
    end
  end

  describe "GET show" do

    it "should retun all the post of that group" do 
      
      get :show, id: group0.id
      expect(assigns[:posts]).to include(post1)
    end
  end

  describe "GET my_groups" do
      it "should give all the groups created by user" do
        get :my_groups
        expect(assigns[:groups]).to include(group1)
      end
  end

  describe "GET follow" do
    it "user should be able to follow the group" do
      get :follow, id: group0.id
      expect(user.following?(group0)).to eq(true)
    end
  end

describe "GET unfollow" do
    it "user should be able to follow the group" do
      user.follow(group0)
      expect(user.following?(group0)).to eq(true)
      get :unfollow, id: group0.id
      expect(user.following?(group0)).to eq(false)
    end
  end
end
