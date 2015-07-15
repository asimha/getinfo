class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end
  
  def create
    @message = Message.new()
    @message.message = params[:message]["message"]
    @message.user_id = current_user.id
    @message.save
    PrivatePub.publish_to("/messages/new", message: @message)
  end

end

