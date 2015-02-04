class GroupPolicy
  attr_reader :user, :group

  def initialize(user, group)
    @user = user
    @group = group
  end

  def show?
    group.user_id == user.id or user.following?(group)
  end

  def edit?
    group.user_id == user.id
  end
end