require "rails_helper"

RSpec.describe "User registration", type: :request do
  it "creates a parent user successfully" do
    expect {
      post user_registration_path, params: {
        user: {
          name: "山田太郎",
          email: "parent@example.com",
          password: "password",
          password_confirmation: "password"
        },
        role: "parent"
      }
    }.to change(User, :count).by(1)

    user = User.last
    expect(user.role).to eq("parent")
  end

  it "creates a student with student_profile" do
    expect {
      post user_registration_path, params: {
        user: {
          name: "田中花子",
          email: "student@example.com",
          password: "password",
          password_confirmation: "password",
          school_name: "〇〇中学校",
          grade: "中2"
        },
        role: "student"
      }
    }.to change(User, :count).by(1)

    user = User.last
    expect(user.student?).to be true
    expect(user.student_profile).to be_present
  end

  it "does not allow registration without name" do
    post user_registration_path, params: {
      user: {
        email: "no_name@example.com",
        password: "password",
        password_confirmation: "password"
      },
      role: "parent"
    }

    expect(response.body).to include("名前を入力してください")
  end
end
