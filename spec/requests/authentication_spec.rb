require "rails_helper"

RSpec.describe "Authentication and authorization", type: :request do
  let!(:admin) { create(:user, :admin) }
  let!(:parent) { create(:user, role: "parent") }
  let!(:student) { create(:user, :student) }

  it "allows admin to access admin dashboard" do
    sign_in admin
    get admin_root_path
    expect(response).to have_http_status(:ok)
  end

  it "prevents parent from accessing admin dashboard" do
    sign_in parent
    get admin_root_path
    expect(response).to redirect_to(root_path)
  end

  it "prevents student from accessing admin dashboard" do
    sign_in student
    get admin_root_path
    expect(response).to redirect_to(root_path)
  end

  it "prevents inactive user from logging in" do
    parent.update(active: false)
    post user_session_path, params: {
      user: {
        email: parent.email,
        password: "password"
      }
    }
    expect(response.body).to include("アカウントが無効")
  end
end
