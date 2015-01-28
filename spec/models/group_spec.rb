require 'rails_helper'

RSpec.describe Group, :type => :model do
  describe "Check Validation" do
		it "should validate presence of name positive" do

			g = Group.new()
		  g.name = "New Group"
		  
		  expect(g).to be_valid
		end
	end
end
