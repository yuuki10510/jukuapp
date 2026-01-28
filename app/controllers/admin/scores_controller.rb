class Admin::ScoresController < Admin::BaseController
  before_action :set_student
  before_action :set_score, only: [:edit, :update, :destroy]

  def new
    @score = @student.scores.new
  end

  def create
    @score = @student.scores.new(score_params)
    if @score.save
      redirect_to admin_student_path(@student), notice: "成績を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @score.update(score_params)
      redirect_to admin_student_path(@student), notice: "成績を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @score.destroy
    redirect_to admin_student_path(@student), notice: "成績を削除しました"
  end

  private

  def set_student
    @student = User.student.find(params[:student_id])
  end

  def set_score
    @score = @student.scores.find(params[:id])
  end

  def score_params
    params.require(:score).permit(:subject, :score, :test_type, :term)
  end
end
