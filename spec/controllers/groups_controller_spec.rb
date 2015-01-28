require 'rails_helper'

RSpec.describe GroupsController, :type => :controller do

  let(:group0) {FactoryGirl.create(:group)}
  let(:group1) {FactoryGirl.create(:group)}
  let(:group2) {FactoryGirl.create(:group)}
  let(:user) {FactoryGirl.create(:user)}

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
      expect(assigns[:groups]).to match_array([group0, group1, group2])
    end
  end

  describe "GET create" do
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

end
