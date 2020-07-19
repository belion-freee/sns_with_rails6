require 'rails_helper'

RSpec.describe "Blogs", type: :request do
  before {
    timestamp!
    log_in
  }

  describe "GET /blogs" do
    before {
      (1..2).each {|index|
        create(:blog, title: "Title#{index}#{timestamp}")
      }
    }

    context 'when not loged in' do
      it "redirect to sign in" do
        log_out
        get blogs_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when loged in' do
      it "render to index page" do
        get blogs_path
        expect(response.status).to eq(200)
        expect(response.body).to include("Title1#{timestamp}")
        expect(response.body).to include("Title2#{timestamp}")
      end
    end
  end

  describe "GET /blogs/:id" do
    context 'other users blog page' do
      it "render to show page" do
        blog = create(:blog, title: "Show Page#{timestamp}")
        get blog_path(blog)
        expect(response.status).to eq(200)
        expect(response.body).to include("Show Page#{timestamp}")
      end
    end

    context 'own blog page' do
      it "render to show page" do
        blog = create(:blog, user: current_user, title: "Show Page#{timestamp}")
        get blog_path(blog)
        expect(response.status).to eq(200)
        expect(response.body).to include("Show Page#{timestamp}")
      end
    end
  end

  describe "GET /blogs/new" do
    it "render to new page" do
      get new_blog_path
      expect(response.status).to eq(200)
    end
  end

  describe "GET /blogs/:id/edit" do
    context 'other users blog page' do
      it "redirect to index page" do
        blog = create(:blog, title: "Edit Page#{timestamp}")
        get edit_blog_path(blog)
        expect(response).to redirect_to(blogs_path)
      end
    end

    context 'own blog page' do
      it "render to edit page" do
        blog = create(:blog, user: current_user, title: "Edit Page#{timestamp}")
        get edit_blog_path(blog)
        expect(response.status).to eq(200)
        expect(response.body).to include("Edit Page#{timestamp}")
      end
    end
  end

  describe "POST /blogs" do
    context 'valid params' do
      it "redirect to show page" do
        expect {
          post blogs_path, params: { blog: attributes_for(:blog, user: current_user, title: "Create Blog#{timestamp}") }
        }.to change { Blog.count }.by(1)
        blog = Blog.find_by(title: "Create Blog#{timestamp}")
        expect(response).to redirect_to(blog_path(blog))
        follow_redirect!
        expect(response.body).to include("Blog was successfully created.")
        expect(response.body).to include("Create Blog#{timestamp}")
      end
    end

    context 'invalid params' do
      it "render to new page" do
        expect {
          post blogs_path, params: { blog: attributes_for(:blog, user: current_user, title: "") }
        }.to change { Blog.count }.by(0)
        expect(response.status).to eq(200)
        expect(response.body).to include(CGI.escapeHTML("Title can't be blank"))
      end
    end

    context "request format is json" do
      context 'valid params' do
        it "return updated attributes" do
          expect {
            post blogs_path(format: :json), params: { blog: attributes_for(:blog, user: current_user, title: "Create Blog#{timestamp}") }
          }.to change { Blog.count }.by(1)
          expect(response.status).to eq(201)
          expect(json_response["title"]).to eq("Create Blog#{timestamp}")
          expect(json_response["user_id"]).to eq(current_user.id)
        end
      end

      context 'invalid params' do
        it "return error messages" do
          expect {
            post blogs_path(format: :json), params: { blog: attributes_for(:blog, user: current_user, title: "") }
          }.to change { Blog.count }.by(0)
          expect(response.status).to eq(422)
          expect(json_response["title"]).to include("can't be blank")
        end
      end
    end
  end

  describe "PUT /blogs/:id" do
    let(:blog) { create(:blog, user: current_user) }
    context 'valid params' do
      it "redirect to show page" do
        put blog_path(blog), params: { blog: { user_id: current_user.id, title: "Updated #{timestamp}"} }
        expect(response).to redirect_to(blog_path(blog))
        follow_redirect!
        expect(response.body).to include("Blog was successfully updated.")
        expect(response.body).to include("Updated #{timestamp}")
      end
    end

    context 'invalid params' do
      it "render to edit page" do
        put blog_path(blog), params: { blog: { user_id: current_user.id, title: ""} }
        expect(response.status).to eq(200)
        expect(response.body).to include(CGI.escapeHTML("Title can't be blank"))
      end
    end

    context 'try to update other users blog' do
      it "redirect to index page" do
        other_blog = create(:blog)
        put blog_path(other_blog), params: { blog: { user_id: current_user.id, title: "Title"} }
        expect(response).to redirect_to(blogs_path)
      end
    end

    context "request format is json" do
      context 'valid params' do
        it "return updated attributes" do
          put blog_path(blog, format: :json), params: { blog: { user_id: current_user.id, title: "Updated #{timestamp}"} }
          expect(response.status).to eq(200)
          expect(json_response["title"]).to eq("Updated #{timestamp}")
          expect(json_response["user_id"]).to eq(current_user.id)
        end
      end

      context 'invalid params' do
        it "return error messages" do
          put blog_path(blog, format: :json), params: { blog: { user_id: current_user.id, title: ""} }
          expect(response.status).to eq(422)
          expect(json_response["title"]).to include("can't be blank")
        end
      end
    end
  end

  describe 'DELETE /blogs/:id' do
    let(:blog) { create(:blog, user: current_user) }
    context 'delete own blog' do
      it "redirect to index page" do
        delete blog_path(blog)
        expect(response).to redirect_to(blogs_path)
        follow_redirect!
        expect(response.body).to include("Blog was successfully destroyed")
      end
    end

    context 'format is json' do
      it "status 204" do
        delete blog_path(blog, format: :json)
        expect(response.status).to eq(204)
      end
    end

    context 'try to delete other users blog' do
      it "redirect to index page without notice" do
        other_blog = create(:blog)
        delete blog_path(other_blog)
        expect(response).to redirect_to(blogs_path)
        follow_redirect!
        expect(response.body).not_to include("Blog was successfully destroyed")
      end
    end
  end
end
