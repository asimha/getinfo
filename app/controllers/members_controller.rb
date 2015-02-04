class MembersController < ApplicationController

  def index
    @member = Member.all
  end

  def create
    @member = Member.new
    @member.group_id = params[:group_id]
    @member.user_id = current_user.id
    @member.is_confirmed = false
    respond_to do |format|
      if @member.save
        format.html {redirect__to group_path(@member.group_id) }
        format.js {}
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @member = Member.find(params[:id])
    @member.is_confirmed = true
    respond_to do |format|
      if @member.save
        format.html {redirect_to group_path(@member.group_id) }
        format.js {}
      end
    end
  end

  def destroy
    @member = Member.find(params[:id])
    @group = Group.find(params[:group_id])
    @member.destroy
    redirect_to group_path(@group.id)
  end

end
