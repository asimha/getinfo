class PostsController < ApplicationController
  
  before_action :authenticate_user!
  
  def index
    @posts = Post.all
    @group = Group.where("id =  1")
  end
  
  def new
    @group = Group.where("id =  1")
  end

  def show
    @post = Post.find(params[:id])
    @group = Group.where("id =  1")
  end

  def create
	  @post = Post.new(post_params)
	  @post.user_id = current_user.id
    @post.group_id = 1
	  if @post.save
	   redirect_to group_post_path(@post.group_id, @post)
    else
      render 'new'
    end
	end

  def user_posts
    @posts = current_user.posts
  end

	private
  
  def post_params
    params.require(:posts).permit(:title, :text)
  end

end
