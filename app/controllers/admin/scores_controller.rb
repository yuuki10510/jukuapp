class Admin::ScoresController < Admin::BaseController
  before_action :set_student

  def new
    @subjects = Score.subjects.keys
  end

  def create
    term = params[:term]
    test_type = params[:test_type]

    if term.blank? || test_type.blank?
      @subjects = Score.subjects.keys
      flash.now[:alert] = "学期とテスト種別を選択してください"
      return render :new, status: :unprocessable_entity
    end

    ActiveRecord::Base.transaction do
      params[:scores].each do |subject, attrs|
        next if attrs[:score].blank?

        score = @student.scores.find_or_initialize_by(
          subject: subject,
          term: term,
          test_type: test_type
        )

        score.score = attrs[:score]
        score.save!
      end
    end

    redirect_to admin_student_path(@student), notice: "成績を保存しました"
  rescue ActiveRecord::RecordInvalid => e
    @subjects = Score.subjects.keys
    flash.now[:alert] = "入力内容に誤りがあります"
    render :new, status: :unprocessable_entity
  end

  private

  def set_student
    @student = User.student.find(params[:student_id])
  end
end
