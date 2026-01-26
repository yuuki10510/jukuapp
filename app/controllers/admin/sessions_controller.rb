class Admin::SessionsController < Admin::BaseController
  skip_before_action :authenticate_user!, only: [:new, :create, :guest_login]
  skip_before_action :ensure_admin, only: [:new, :create, :guest_login]

  def new
    @user = User.new
  end

  def create
    @user = User.new(email: params[:email])

    if params[:email].blank?
      @user.errors.add(:email, "を入力してください")
    end

    if params[:password].blank?
      @user.errors.add(:password, "を入力してください")
    end

    if @user.errors.any?
      return render :new, status: :unprocessable_entity
    end

    user = User.find_by(email: params[:email])

    if user&.valid_password?(params[:password]) && user.admin?
      sign_in(user)
      redirect_to admin_root_path, notice: "管理者としてログインしました。"
    else
      @user.errors.add(:base, "メールアドレスまたはパスワードが正しくないか、管理者ではありません。")
      render :new, status: :unprocessable_entity
    end
  end

  def guest_login
    user = User.find_or_create_by!(email: "admin_guest@example.com") do |u|
      u.password = SecureRandom.urlsafe_base64
      u.name = "ゲスト管理者"
      u.role = "admin"
    end

    sign_in(user)
    redirect_to admin_root_path, notice: "ゲスト管理者としてログインしました。"
  end

  def destroy
    sign_out(current_user)
    redirect_to admin_login_path, notice: "ログアウトしました。"
  end
end
