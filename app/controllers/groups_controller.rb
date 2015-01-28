class GroupsController < ApplicationController
  def index
  	@groups = Group.all
  end

  def new
  end

  def create
  	@group = Group.new(group_params)
	  @group.user_id = current_user.id
	  if @group.save
	   redirect_to @group
    else
      render 'new'
    end
  end

  private
  
  def group_params
    params.require(:groups).permit(:name)
  end
end
