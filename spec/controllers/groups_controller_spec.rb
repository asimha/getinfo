require 'rails_helper'

RSpec.describe GroupsController, :type => :controller do

  let(:group0) {FactoryGirl.create(:group)}
  let(:group1) {FactoryGirl.create(:group)}
  let(:group2) {FactoryGirl.create(:group)}
  let(:user) {FactoryGirl.create(:user)}
  let(:post1) {FactoryGirl.create(:post, group_id: group0.id)}
  let(:post2) {FactoryGirl.create(:post, group_id: group1.id)}

  before(:each) do
   sign_in(user)
  end

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(assigns[:groups]).to match_array([group0, group1, group2])
    end
  end

  describe "POST create" do
    it "returns http success" do
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
      expect(assigns[:post]).to match_array([post1])
    end
  end

end
