class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def home
    if current_user.admin?
      redirect_to admin_students_path
    else
      @announcements = Announcement.order(created_at: :desc)
    end
  end
end
