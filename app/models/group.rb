class Group < ActiveRecord::Base
	has_many :users
	has_many :posts

	#validations
	validates_presence_of :name
end
