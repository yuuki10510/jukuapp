class Admin::WithdrawalsController < Admin::BaseController
  before_action :set_student

  def new
    @withdrawal = Withdrawal.new
  end

  def create
    @withdrawal = Withdrawal.new(withdrawal_params.merge(student: @student))
    if @withdrawal.save
      @student.student_profile.update(active: false)
      redirect_to admin_students_path, notice: "退塾処理が完了しました"
    else
      render :new
    end
  end

  private

  def set_student
    @student = User.student.find(params[:student_id])
  end

  def withdrawal_params
    params.require(:withdrawal).permit(:reason)
  end
end
