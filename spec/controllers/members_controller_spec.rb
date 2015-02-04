require 'rails_helper'

RSpec.describe MembersController, :type => :controller do

  let(:user) {FactoryGirl.create(:user)}
  let(:group) {FactoryGirl.create(:group, user_id: user.id)}
  let(:member) {FactoryGirl.create(:member, user_id: user.id, group_id: group.id)}

  before(:each) do
    sign_in(user)
  end

  describe "POST create" do

    it "user should be able to create a member" do
      
      expect do
        post :create, group_id: group.id, user_id: user.id 
      end.to change(Member, :count).by(1)
    
    end
  
  end

  describe "PUT update" do
    it "should update member to confirm" do
      member
      patch :update, group_id: group.id, id: member.id
      expect(response).to redirect_to(group_path(member.group_id))
    end
  end

  describe "DELETE destroy" do
    let(:user1) {FactoryGirl.create(:user)}
    let(:member_2) {FactoryGirl.create(:member, user_id: user1.id, group_id: group.id)}

    it "should delete the member passes" do
      delete :destroy, group_id: member_2.group_id, id: member_2.id
      expect(response).to redirect_to(group_path(member_2.group.id))
    end
  end

end
