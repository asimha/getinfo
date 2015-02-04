require 'rails_helper'

RSpec.describe Group, :type => :model do

  let(:user) {FactoryGirl.create(:user)}
  let(:user1) {FactoryGirl.create(:user)}
  let(:group) {FactoryGirl.create(:group, user_id: user.id)}
  let(:member) {FactoryGirl.create(:member, user_id: user.id, group_id: group.id, is_confirmed: true)}
  let(:member1) {FactoryGirl.create(:member, user_id: user1.id, group_id: group.id, is_confirmed: false)}

  describe "Check Validation" do
		it "should validate presence of name positive" do

		  g = Group.new()
		  g.name = "New Group"
		  
		  expect(g).to be_valid
		end
	end

  describe "check Member" do
    
    it "should check weather the user is member of the group" do
      member
      expect(group.is_member?(user)).to be_truthy
    end

    it "should return true if user is requested for member" do
      member1
      expect(group.is_requested_member?(user1)).to be_truthy
    end
  
  end
end
