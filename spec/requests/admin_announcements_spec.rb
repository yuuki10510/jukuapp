require "rails_helper"

RSpec.describe "Admin::Announcements", type: :request do
  let!(:admin) { create(:user, :admin) }

  before do
    post user_session_path, params: {
      user: {
        email: admin.email,
        password: "password"
      }
    }
  end

  it "creates an announcement" do
    expect {
      post admin_announcements_path, params: {
        announcement: {
          title: "重要連絡",
          body: "明日は休講です。"
        }
      }
    }.to change(Announcement, :count).by(1)
  end

  it "updates an announcement" do
    announcement = create(:announcement)
    patch admin_announcement_path(announcement), params: {
      announcement: { title: "変更連絡" }
    }
    expect(announcement.reload.title).to eq("変更連絡")
  end

  it "deletes an announcement" do
    announcement = create(:announcement)
    expect {
      delete admin_announcement_path(announcement)
    }.to change(Announcement, :count).by(-1)
  end
end