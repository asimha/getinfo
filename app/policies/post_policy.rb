class PostPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def show?
    user.admin? or not post.published?
  end

  def update?
    @post.user_id == @user.id
  end

  def edit?
    update?
  end

  def destroy?
    @post.user_id == current_user.id
  end

end