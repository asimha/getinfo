class GroupsController < ApplicationController

  before_action :authenticate_user!
  
  def index
  	@groups = Group.all
  end

  def new
  end

  def show
    @group = Group.find(params[:id])
    @post = Post.where("group_id = ? ", params[:id])
  end

  def create
  	@group = Group.new(group_params)
	  @group.user_id = current_user.id
	  if @group.save
	   redirect_to groups_path
    else
      render 'new'
    end
  end

   def follow
    @group = Group.find(params[:id])
    current_user.follow(@group)
    current_user.save
    redirect_to :back
    # redirect_to groups_path
  end

  def unfollow
    @group = Group.find(params[:id])
    current_user.stop_following(@group)
    current_user.save
    # redirect_to groups_path
    redirect_to :back
  end
  private
  
  def group_params
    params.require(:groups).permit(:name)
  end
end
