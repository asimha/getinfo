require 'rails_helper'

RSpec.describe PostsController, :type => :controller do

  let(:user) {FactoryGirl.create(:user)}
  let(:user1) {FactoryGirl.create(:user, email: "user1@domain.com")}
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
      expect(assigns[:posts]).to match_array([post0, post1, post2])
    end
  end

  describe "POST create" do

    it "user should be able to create a post" do
      post_params = {
      group_id: group.id,
        posts: {
          title: "My post",
          text: "post text",
        }
      }
      expect do
        post :create, post_params, group_id: group.id
      end.to change(Post, :count).by(1)
      expect(user.posts.count).to eq(1)
    end

    it "should not create a post with invalid params" do
      post_params = {
        group_id: group.id,
        user_id: user.id,
        posts: {
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

  describe "GET user_posts" do

    it  "should return all the post of the current user" do
      get :user_posts, user: user
      expect(assigns[:posts]).to match_array([post2])
    end

    it  "should not return other users post" do
      get :user_posts, user: user
      expect(assigns[:posts].count).to eq(0)
    end
  end

end
