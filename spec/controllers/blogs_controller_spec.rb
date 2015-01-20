require 'rails_helper'

RSpec.describe BlogsController, :type => :controller do

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
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
        post :create, blog_params
      end.to change(Blog, :count).by(1)

      get :show, id: Blog.first.id
      expect(assigns[:blog]).to eq(Blog.first)
    end
  
  end

end
