class Admin::BaseController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]
  before_action :ensure_admin, except: [:new, :create]

  private

  def ensure_admin
    redirect_to root_path, alert: "管理者専用ページです" unless current_user.admin?
  end
end
