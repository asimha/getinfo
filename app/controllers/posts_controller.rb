class PostsController < ApplicationController
  
  before_action :authenticate_user!
  
  def index
    @posts = Post.all
  end
  
  def new  	
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
	  @post = Post.new(post_params)
	  @post.user_id = current_user.id
	  if @post.save
	   redirect_to @post
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
