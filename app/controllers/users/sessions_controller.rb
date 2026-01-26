class Users::SessionsController < Devise::SessionsController
  def guest_admin_sign_in
    user = User.find_or_create_by!(email: "guest_admin@example.com") do |u|
      u.password = SecureRandom.urlsafe_base64
      u.name = "ゲスト管理者"
      u.role = "admin"
    end

    sign_in user
    redirect_to admin_root_path, notice: "ゲスト管理者としてログインしました。"
  end

  def guest_parent_sign_in
    user = User.find_or_create_by!(email: "guest_parent@example.com") do |u|
      u.password = SecureRandom.urlsafe_base64
      u.name = "ゲスト保護者"
      u.role = "parent"
    end

    sign_in user
    redirect_to dashboard_path, notice: "ゲスト保護者としてログインしました。"
  end
end
