class CommentsController < ApplicationController

  def new
    
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.post_id = params[:post_id]
    if @comment.save
      redirect_to group_post_path(@comment.post.group_id, @comment.post)
    else
      render 'new'
    end
  end

  def index
    @comments = Comment.where('post_id = ?', params[:post_id] )
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end



end
