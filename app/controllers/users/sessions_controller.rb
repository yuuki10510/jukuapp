class Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_signed_out_user, only: [:new]

  def destroy
    sign_out(current_user)
    flash.clear
    flash[:notice] = "ログアウトしました。"
    redirect_to new_user_session_path
  end

  def guest_parent_sign_in
    user = User.find_or_create_by!(email: "guest_parent@example.com") do |u|
      u.password = SecureRandom.urlsafe_base64
      u.name = "ゲスト保護者"
      u.role = "parent"
    end

    sign_in user
    flash.clear
    flash[:notice] = "ゲスト保護者としてログインしました。"
    redirect_to dashboard_path
  end
end