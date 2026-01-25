class Users::RegistrationsController < Devise::RegistrationsController
  def new
    @role = params[:role]
    super
  end

  def create
    super do |resource|
      resource.role = params[:role] || params.dig(:user, :role)
      resource.save

      if resource.student?
        StudentProfile.create(
          user: resource,
          school_name: params[:user][:school_name],
          grade: params[:user][:grade],
          active: true
        )
      end
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
