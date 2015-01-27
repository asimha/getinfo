require 'rails_helper'

RSpec.describe Post, :type => :model do
  
	describe "Check Validation" do
		it "should validate presence of text and title positive" do

			b = Post.new()
		  b.title = "New Post"
		  b.text = "text" 
		  
		  expect(b).to be_valid
		end

		it "should validate presence of text and title negative" do

			b = Post.new()
		  b.title = "New Post"
		  b.text = nil
		  
		  expect(b).to be_invalid
		end
	end

end
