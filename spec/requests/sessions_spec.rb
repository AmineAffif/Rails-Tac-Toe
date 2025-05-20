require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let(:user) { create(:user) }

  describe "GET /new" do
    it "returns http success" do
      get new_session_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "logs in the user with valid credentials" do
      post session_path, params: { email: user.email, password: "password" }
      expect(session[:user_id]).to eq(user.id)
      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET /destroy" do
    it "redirects after logout" do
      delete session_path
      expect(response).to have_http_status(:found) # 302 redirect
      expect(response).to redirect_to(root_path)
    end
  end
end
