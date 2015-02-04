class Group < ActiveRecord::Base
	
	#association
	has_many :members
	has_many :users, :dependent => :destroy, :through => :members
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

	def is_member?(user)
    result = Member.where("user_id = ? and group_id = ? and is_confirmed = ?", user.id, self.id, true).first
    return true if result.present? 
  end

  def is_requested_member?(user)
    result = Member.where("user_id = ? and group_id = ? and is_confirmed = ?", user.id, self.id, false).first
    return true if result.present? 
  end
	
end
