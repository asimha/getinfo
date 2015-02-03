require 'rails_helper'

RSpec.describe PostsController, :type => :controller do

  let(:user) {FactoryGirl.create(:user)}
  let(:user1) {FactoryGirl.create(:user)}
  let(:post0) {FactoryGirl.create(:post, user_id: user1.id, group_id: group.id)}
  let(:post1) {FactoryGirl.create(:post)}
  let(:post2) {FactoryGirl.create(:post, user_id: user.id )}
  let(:group) {FactoryGirl.create(:group, user_id: user.id)}

	before(:each) do
   sign_in(user)
 end

  describe "GET index" do
    it "returns http success" do
      get :index, group_id: group.id
      expect(response).to have_http_status(:success)
      expect(assigns[:posts]).to include(post1, post0, post2)
    end
  end

  describe "POST create" do

    it "user should be able to create a post" do
      post_params = {
      group_id: group.id,
        post: {
          title: "My post",
          text: "post text",
        }
      }
      expect do
        post :create, post_params
      end.to change(Post, :count).by(1)
      expect(user.posts.count).to eq(1)
    end

    it "should not create a post with invalid params" do
      post_params = {
        group_id: group.id,
        user_id: user.id,
        post: {
          title: nil,
          text: "post text",
        }
      }
      expect do
        post :create, post_params
      end.to change(Post, :count).by(0)
      expect(user.posts.count).to eq(0)
    end
  
  end

  describe "GET show" do
    it "should return post for which id is passed" do
      get :show, id: post0.id, group_id: group.id
      expect(assigns[:post]).to eq(post0)
    end
  end

  describe "GET edit" do
    it "shoulbe able to edit the post" do
      get :edit, :id => post0.id, group_id: post0.group_id
      expect(assigns[:post]).to eq(post0)
    end
  end

  describe "PUT update" do
    let(:post_update) {FactoryGirl.create(:post, text: "my text", group_id: group.id)}
    
    it "should be able to update the post" do
      post_params = {
        group_id: post_update.group_id,
        id: post_update.id,
        post: {
          text: "changed text"
        }
      }
      old_post = post_update

      put :update, post_params
      expect(response).to redirect_to(group_post_path(post_update.group_id, post_update))
    end
  
  end

  describe "GET user_posts" do

    it  "should return all the post of the current user" do
      post2
      get :user_posts, user: user
      expect(assigns[:posts]).to include(post2)
    end

    it  "should not return other users post" do
      get :user_posts, user: user
      expect(assigns[:posts].count).to eq(0)
    end
  end

end
