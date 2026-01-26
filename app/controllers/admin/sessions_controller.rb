class Admin::SessionsController < Admin::BaseController

  def new
    self.resource = resource_class.new
  end

  def create
    self.resource = warden.authenticate(auth_options)

    if self.resource&.admin?
      sign_in(resource_name, resource)
      redirect_to admin_root_path, notice: "管理者としてログインしました。"
    else
      flash.now[:alert] = "管理者アカウントのみログインできます。"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    sign_out(resource_name)
    redirect_to admin_login_path, notice: "ログアウトしました。"
  end
end
