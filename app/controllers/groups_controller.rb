class GroupsController < ApplicationController

  before_action :authenticate_user!
  
  def index
  	@groups = Group.all
  end

  def new
  end

  def show
    @group = Group.find(params[:id])
    @user = User.find(@group.user_id)
    @posts = @group.posts
    authorize @group
  end

  def create
  	@group = Group.new(group_params)
	  @group.user_id = current_user.id
    if @group.save
      current_user.follow(@group)
	    redirect_to groups_path
    else
      render 'new'
    end
  end

  def my_groups
    @groups = Group.where("user_id = ?", current_user.id)
  end

   def follow
    @group = Group.find(params[:id])
    current_user.follow(@group)
    current_user.save
    redirect_to groups_path
  end

  def unfollow
    @group = Group.find(params[:id])
    current_user.stop_following(@group)
    current_user.save
    redirect_to groups_path
  end
  private
  
  def group_params
    params.require(:groups).permit(:name)
  end
end
