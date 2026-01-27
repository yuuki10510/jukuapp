class Admin::StudentsController < Admin::BaseController

  def index
    @students = User.student.includes(:student_profile).where(active: true)
    @students = @students.where(student_profiles: { grade: params[:grade] }) if params[:grade].present?
  end

  def show
    @student = User.student.find(params[:id])
    @scores = @student.scores
  end

  def withdraw
    @student = User.student.find(params[:id])

    if @student.update(active: false, withdrawal_reason: params[:withdrawal_reason])
      redirect_to admin_students_path, notice: "退塾処理が完了しました。"
    else
      render :show
    end
  end
end
