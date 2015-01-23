require 'rails_helper'

RSpec.describe PostsController, :type => :controller do

  let(:user) {FactoryGirl.create(:user)}
  let(:user1) {FactoryGirl.create(:user)}
  let(:post0) {FactoryGirl.create(:post)}
  let(:post1) {FactoryGirl.create(:post)}
	let(:post2) {FactoryGirl.create(:post)}

	before(:each) do
   sign_in(user)
 end

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
      expect(assigns[:posts]).to match_array([post0, post1, post2])
    end
  end

  describe "POST create" do
    
    it "user should be able to create and view the post" do
      post_params = {
        posts: {
          title: "My post",
          text: "post text",
        }
      }
      expect do
        post :create, post_params, user_id: user.id
      end.to change(Post, :count).by(1)
      expect(user.posts.count).to eq(1)

      get :show, id: Post.first.id
      expect(assigns[:post]).to eq(Post.first)
    end
  
  end

end
