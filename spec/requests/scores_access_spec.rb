require "rails_helper"

RSpec.describe "Scores access", type: :request do
  let!(:student) { create(:user, :student) }
  let!(:profile) { create(:student_profile, user: student) }
  let!(:score)   { create(:score, student: student, score: 80) }

  let!(:parent) { create(:user, role: "parent") }
  let!(:link)   { ParentStudent.create(parent: parent, student: student) }

  it "allows student to view own scores" do
    post user_session_path, params: {
      user: { email: student.email, password: "password" }
    }

    get scores_path
    expect(response.body).to include(score.score.to_s)
  end

  it "allows parent to view child's scores" do
    post user_session_path, params: {
      user: { email: parent.email, password: "password" }
    }

    get scores_path
    expect(response.body).to include(score.score.to_s)
  end

  it "prevents other students from viewing scores" do
    other_student = create(:user, :student)

    post user_session_path, params: {
      user: { email: other_student.email, password: "password" }
    }

    get scores_path
    expect(response.body).not_to include(score.score.to_s)
  end
end
