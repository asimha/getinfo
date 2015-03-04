require 'rails_helper'

RSpec.describe CommentsController, :type => :controller do
  let(:user) {FactoryGirl.create(:user)}
  let(:group) {FactoryGirl.create(:group, user_id: user.id)}
  let(:post1) {FactoryGirl.create(:post, group_id: group.id, user_id: user.id)}
  let(:post2) {FactoryGirl.create(:post, group_id: group.id, user_id: user.id)}
  let(:comment1){FactoryGirl.create(:comment, text: "comment1", post_id: post1.id)}
  let(:comment2){FactoryGirl.create(:comment, text: "comment2", post_id: post1.id)}
  let(:comment3){FactoryGirl.create(:comment, text: "comment3", post_id: post2.id)}

  before(:each) do
    sign_in(user)
  end

  describe "POST create" do

    it "user should be able to comment on a post" do
      comment_params = {
        post_id: post1.id, 
        group_id: group.id,
        comment:{
        text: "text",
      }
      }
      expect do 
        post :create, comment_params
      end.to change(Comment, :count).by(1)
    end
  end

  describe "GET index" do
    it "should return all the comment related to a post" do
      get :index, post_id: post1.id, group_id: group.id
     expect(assigns[:comments]).to include(comment1, comment2)
    end
    
    it "should not include other post comments" do
      get :index, post_id: post1.id, group_id: group.id
      expect(assigns[:comments]).not_to include(comment3)
    end
  end

end
