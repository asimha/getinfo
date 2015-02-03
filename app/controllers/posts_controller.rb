class PostsController < ApplicationController
  
  before_action :authenticate_user!
  
  def index
    @posts = Post.all
    @group = Group.find(params[:group_id])
  end
  
  def new
    @group = Group.find(params[:group_id])
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
    @group = Group.find(params[:group_id])
  end

  def create
	  @post = Post.new(post_params)
	  @post.user_id = current_user.id
    @post.group_id = params[:group_id]
	  if @post.save
      redirect_to group_post_path(@post.group_id, @post)
    else
      render 'new'
    end
	end

  def edit
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
    authorize @post
  end

  def update
    @post = Post.find(params[:id])
    @group = Group.find(params[:group_id])
    if @post.update(post_params)
      redirect_to group_post_path(@group, @post)
    else
      render 'edit'
    end
  end

  def destroy
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
    @post.destroy
    authorize @post
    redirect_to group_path(@group.id)
  end

  def user_posts
    @posts = current_user.posts
  end

	private
  
  def post_params
    params.require(:post).permit(:title, :text)
  end

end
