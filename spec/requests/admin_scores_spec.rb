require "rails_helper"

RSpec.describe "Admin::Scores", type: :request do
  let!(:admin) { create(:user, :admin) }
  let!(:student) { create(:user, :student) }
  let!(:profile) { create(:student_profile, user: student) }

  before do
    post user_session_path, params: {
      user: {
        email: admin.email,
        password: "password"
      }
    }
  end

  it "creates a score" do
    expect {
      post admin_student_scores_path(student), params: {
        score: {
          subject: :math,
          test_type: :regular,
          term: :first_mid,
          score: 90
        }
      }
    }.to change(Score, :count).by(1)
  end

  it "updates a score" do
    score = create(:score, student: student)

    patch admin_student_score_path(student, score), params: {
      score: { score: 95 }
    }

    expect(score.reload.score).to eq(95)
  end

  it "deletes a score" do
    score = create(:score, student: student)

    expect {
      delete admin_student_score_path(student, score)
    }.to change(Score, :count).by(-1)
  end
end