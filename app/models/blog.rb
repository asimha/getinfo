class Blog < ActiveRecord::Base

	#associaton
	belongs_to :user

	
	#validations
	validates_presence_of :title
	validates_presence_of :text
end
