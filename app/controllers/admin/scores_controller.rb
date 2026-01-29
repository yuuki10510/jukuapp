class Admin::ScoresController < Admin::BaseController
  before_action :set_student

  def new
    @subjects = Score.subjects.keys
  end

  def create
    @term = params[:term]
    @test_type = params[:test_type]
    @subjects = Score.subjects.keys

    ActiveRecord::Base.transaction do
      @subjects.each do |subject|
        attrs = params.dig(:scores, subject)
        next if attrs.blank? || attrs[:score].blank?

        score = @student.scores.find_or_initialize_by(
          subject: subject,
          term: @term,
          test_type: @test_type
        )

        score.update!(score: attrs[:score])
      end
    end

    redirect_to admin_student_path(@student),
                notice: "成績を保存しました"

  rescue ActiveRecord::RecordInvalid
    flash.now[:alert] = "入力内容に誤りがあります"
    render :new, status: :unprocessable_entity
  end

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
    @term = params[:term]
    @test_type = params[:test_type]
    @subjects = Score.subjects.keys

    ActiveRecord::Base.transaction do
      @subjects.each do |subject|
        attrs = params.dig(:scores, subject)
        next if attrs.blank? || attrs[:score].blank?

        score = @student.scores.find_or_initialize_by(
          subject: subject,
          term: @term,
          test_type: @test_type
        )

        score.update!(score: attrs[:score])
      end
    end

    redirect_to admin_student_path(@student),
                notice: "成績を更新しました"

  rescue ActiveRecord::RecordInvalid
    @scores_by_subject =
      @student.scores
              .where(term: @term, test_type: @test_type)
              .index_by(&:subject)

    flash.now[:alert] = "入力内容に誤りがあります"
    render :edit_test, status: :unprocessable_entity
  end

  def destroy_test
    @student.scores
            .where(term: params[:term], test_type: params[:test_type])
            .destroy_all

    redirect_to admin_student_path(@student),
                notice: "テストの成績を削除しました"
  end

  private

  def set_student
    @student = User.student.find(params[:student_id])
  end
end
