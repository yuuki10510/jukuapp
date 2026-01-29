class AnnouncementsController < ApplicationController
  before_action :authenticate_user!

  def index
    @announcements = Announcement
                       .visible_to(current_user)
                       .order(created_at: :desc)
  end

  def show
    @announcement = Announcement.find(params[:id])

    unless Announcement.visible_to(current_user).exists?(@announcement.id)
      redirect_to announcements_path, alert: "このお知らせは閲覧できません"
    end
  end
end
