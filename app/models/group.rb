class Group < ActiveRecord::Base
	
	#association
	has_many :users, :dependent => :destroy
	has_many :posts, :dependent => :destroy

	#validations
	validates_presence_of :name

	acts_as_followable

	def display_follow_button?(user, group)
		user.following?(group) && user.id != group.user_id
	end

	def display_unfollow_button?(user, group)
		!user.following?(group) && user.id != group.user_id
	end
	
end
