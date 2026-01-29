class Admin::StudentsController < Admin::BaseController

  def index
    @students = User.student.joins(:student_profile)

    unless params[:include_withdrawn] == "1"
      @students = @students.where(student_profiles: { active: true })
    end

    if params[:grade].present?
      @students = @students.where(student_profiles: { grade: StudentProfile.grades[params[:grade]] })
    end
  end

  def show
    @student = User.student.find(params[:id])
    @scores  = @student.scores

    totals = Score.total_scores_by_test(@scores)

    @line_chart_data = Score.build_line_chart_data(@scores)
  end

  def withdraw
    @student = User.student.find(params[:id])

    if @student.student_profile.update(active: false, withdrawal_reason: params[:withdrawal_reason])
      redirect_to admin_students_path, notice: "退塾処理が完了しました。"
    else
      render :show
    end
  end
end
