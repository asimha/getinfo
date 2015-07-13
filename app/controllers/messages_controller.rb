class MessagesController < ApplicationController
  def index
    @messages = Message.all
    @user = current_user
  end
  
  def create
    @message = Message.new()
    @message.message = params[:message]["message"]
    @message.save
    PrivatePub.publish_to("/messages/new", message: @message)
  end

end

