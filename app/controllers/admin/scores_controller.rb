class Admin::ScoresController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin
  before_action :set_student

  def new
    @score = @student.scores.new
  end

  def create
    @score = @student.scores.new(score_params)
    if @score.save
      redirect_to admin_student_path(@student), notice: "成績を登録しました"
    else
      render :new
    end
  end

  def edit
    @score = @student.scores.find(params[:id])
  end

  def update
    @score = @student.scores.find(params[:id])
    if @score.update(score_params)
      redirect_to admin_student_path(@student), notice: "成績を更新しました"
    else
      render :edit
    end
  end

  private

  def set_student
    @student = User.student.find(params[:student_id])
  end

  def score_params
    params.require(:score).permit(:subject, :score, :test_type, :term)
  end

  def ensure_admin
    redirect_to root_path unless current_user.admin?
  end
end
