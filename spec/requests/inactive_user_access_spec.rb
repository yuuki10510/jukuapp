require "rails_helper"

RSpec.describe "Inactive user access", type: :request do
  let!(:student) { create(:user, :student, active: false) }

  it "prevents inactive user from accessing dashboard" do
    post user_session_path, params: {
      user: {
        email: student.email,
        password: "password"
      }
    }

    get dashboard_path

    expect(response.status).to be_in([302, 404])
  end
end
