class Admin::StudentsController < Admin::BaseController

  def index
    @students = User.student.includes(:student_profile)
    @students = @students.where(student_profiles: { grade: params[:grade] }) if params[:grade].present?
  end

  def show
    @student = User.student.find(params[:id])
    @scores = @student.scores
  end
end
