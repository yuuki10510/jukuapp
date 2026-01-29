class Admin::ScoresController < Admin::BaseController
  before_action :set_student

  def edit_test
    @term = params[:term]
    @test_type = params[:test_type]
    @subjects = Score.subjects.keys

    @scores_by_subject =
      @student.scores
              .where(term: @term, test_type: @test_type)
              .index_by(&:subject)
  end

  def update_test
    term = params[:term]
    test_type = params[:test_type]

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

    redirect_to admin_student_path(@student),
      notice: "成績を更新しました"
  rescue ActiveRecord::RecordInvalid
    @term = term
    @test_type = test_type
    @subjects = Score.subjects.keys
    @scores_by_subject = {}
    flash.now[:alert] = "入力内容に誤りがあります"
    render :edit_test, status: :unprocessable_entity
  end

  def destroy_test
    term = params[:term]
    test_type = params[:test_type]

    @student.scores
            .where(term: term, test_type: test_type)
            .destroy_all

    redirect_to admin_student_path(@student),
      notice: "テストの成績を削除しました"
  end

  private

  def set_student
    @student = User.student.find(params[:student_id])
  end
end
