class Admin::DashboardController < Admin::BaseController
  def index
    @recent_announcements = Announcement
                              .order(created_at: :desc)
                              .limit(5)    
  end
end
