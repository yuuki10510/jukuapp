class Admin::StudentsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin

  def index
    @students = User.student.includes(:student_profile)
    @students = @students.where(student_profiles: { grade: params[:grade] }) if params[:grade].present?
  end

  def show
    @student = User.student.find(params[:id])
    @scores = @student.scores
  end

  private

  def ensure_admin
    redirect_to root_path unless current_user.admin?
  end
end
