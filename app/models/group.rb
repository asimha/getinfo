class Group < ActiveRecord::Base
	
	#association
	has_many :users, :dependent => :destroy
	has_many :posts, :dependent => :destroy

	#validations
	validates_presence_of :name

	acts_as_followable
end
