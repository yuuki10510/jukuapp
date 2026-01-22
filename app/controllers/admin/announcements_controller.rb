class Admin::AnnouncementsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin

  def index
    @announcements = Announcement.all
  end

  def new
    @announcement = Announcement.new
  end

  def create
    @announcement = Announcement.new(announcement_params)
    if @announcement.save
      redirect_to admin_announcements_path, notice: "お知らせを作成しました"
    else
      render :new
    end
  end

  def edit
    @announcement = Announcement.find(params[:id])
  end

  def update
    @announcement = Announcement.find(params[:id])
    if @announcement.update(announcement_params)
      redirect_to admin_announcements_path, notice: "お知らせを更新しました"
    else
      render :edit
    end
  end

  def destroy
    @announcement = Announcement.find(params[:id])
    @announcement.destroy
    redirect_to admin_announcements_path, notice: "お知らせを削除しました"
  end

  private

  def announcement_params
    params.require(:announcement).permit(:title, :body)
  end

  def ensure_admin
    redirect_to root_path unless current_user.admin?
  end
end
