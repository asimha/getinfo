require 'rails_helper'

RSpec.describe Blog, :type => :model do
  
	describe "Check Validation" do
		it "should validate presence of text and title positive" do

			b = Blog.new()
		  b.title = "New Blog"
		  b.text = "text" 
		  
		  expect(b).to be_valid
		end

		it "should validate presence of text and title negative" do

			b = Blog.new()
		  b.title = "New Blog"
		  b.text = nil  # Note this line
		  
		  expect(b).to be_invalid
		end
	end

end
