class Post < ActiveRecord::Base

	#associaton
	belongs_to :user
  has_many :comments

	
	#validations
	validates_presence_of :title
	validates_presence_of :text
end
