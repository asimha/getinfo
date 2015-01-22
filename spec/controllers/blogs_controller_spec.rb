require 'rails_helper'

RSpec.describe BlogsController, :type => :controller do

  let(:user) {FactoryGirl.create(:user)}
  let(:user1) {FactoryGirl.create(:user)}
  let(:blog0) {FactoryGirl.create(:blog)}
  let(:blog1) {FactoryGirl.create(:blog)}
	let(:blog2) {FactoryGirl.create(:blog)}

	before(:each) do
   sign_in(user)
 end

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
      expect(assigns[:blogs]).to match_array([blog0, blog1, blog2])
    end
  end

  describe "POST create" do
    
    it "user should be able to create and view the blog" do
      blog_params = {
        blogs: {
          title: "My Blog",
          text: "Blog text",
        }
      }
      expect do
        post :create, blog_params, user_id: user.id
      end.to change(Blog, :count).by(1)
      expect(user.blogs.count).to eq(1)

      get :show, id: Blog.first.id
      expect(assigns[:blog]).to eq(Blog.first)
    end
  
  end

end
