require "rails_helper"

RSpec.describe "Admin::Students", type: :request do
  let!(:admin) { create(:user, :admin) }
  let!(:student1) { create(:user, :student, name: "山田") }
  let!(:profile1) { create(:student_profile, user: student1, grade: "中1", active: true) }

  let!(:student2) { create(:user, :student, name: "田中") }
  let!(:profile2) { create(:student_profile, user: student2, grade: "中2", active: false) }

  before do
    post user_session_path, params: {
      user: {
        email: admin.email,
        password: "password"
      }
    }
  end

  it "shows only active students by default" do
    get admin_students_path
    expect(response.body).to include("山田")
    expect(response.body).not_to include("田中")
  end

  it "filters by grade" do
    get admin_students_path, params: { grade: "中1" }
    expect(response.body).to include("山田")
    expect(response.body).not_to include("田中")
  end

  it "shows withdrawn students when checkbox is checked" do
    get admin_students_path, params: { include_withdrawn: "1" }
    expect(response.body).to include("田中")
  end
end
