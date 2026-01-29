class Admin::ScoresController < Admin::BaseController
  before_action :set_student

  def new
    @subjects = Score.subjects.keys
  end

  def create
    term = params[:term]
    test_type = params[:test_type]

    ActiveRecord::Base.transaction do
      params[:scores].each do |subject, attrs|
        @student.scores.create!(
          subject: subject,
          score: attrs[:score],
          term: term,
          test_type: test_type
        )
      end
    end

    redirect_to admin_student_path(@student), notice: "成績を登録しました"
  rescue ActiveRecord::RecordInvalid
    @subjects = Score.subjects.keys
    flash.now[:alert] = "入力に誤りがあります"
    render :new, status: :unprocessable_entity
  end

  private

  def set_student
    @student = User.student.find(params[:student_id])
  end
end
