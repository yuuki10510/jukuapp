require "rails_helper"

RSpec.describe "Authentication and authorization", type: :request do
  let!(:admin)   { create(:user, :admin, active: true, password: "password") }
  let!(:parent)  { create(:user, role: "parent", active: true, password: "password") }
  let!(:student) { create(:user, :student, active: true, password: "password") }

  def login(user)
    post user_session_path, params: {
      user: {
        email: user.email,
        password: "password"
      }
    }
  end

  it "allows admin to access admin dashboard" do
    login(admin)
    get admin_root_path
    expect(response).to have_http_status(:ok)
  end

  it "prevents parent from accessing admin dashboard" do
    login(parent)
    get admin_root_path
    expect(response).to redirect_to(root_path)
  end

  it "prevents student from accessing admin dashboard" do
    login(student)
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

    follow_redirect!
    expect(flash[:alert]).to include("無効なアカウントです")
  end
end
